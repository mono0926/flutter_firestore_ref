import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';
import 'package:simple_logger/simple_logger.dart';

SimpleLogger get _logger => SimpleLogger();

@immutable
class DocumentRef<E, D extends Document<E>> {
  DocumentRef({
    @required String id,
    @required this.collectionRef,
  }) : ref = collectionRef.ref.document(id);

  final CollectionRef<E, D> collectionRef;
  final DocumentReference ref;

  Stream<D> document() {
    return ref.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        _logger.warning('$D not found(id: ${ref.documentID})');
        return null;
      }
      return collectionRef.decoder(snapshot);
    });
  }

  Future<D> get({Transaction transaction}) async {
    final snapshot =
        await (transaction == null ? ref.get() : transaction.get(ref));
    if (!snapshot.exists) {
      _logger.warning('$D not found(id: ${ref.documentID})');
      return null;
    }
    return collectionRef.decoder(snapshot);
  }

  /// すでにあるデータに対して
  /// マージと似ているがそのキーの配下のものは置き換わる
  Future<void> update(
    E entity, {
    WriteBatch batch,
    Transaction transaction,
  }) {
    return updateData(
      collectionRef.encoder(entity),
      batch: batch,
      transaction: transaction,
    );
  }

  /// すでにあるデータに対して
  /// マージと似ているがそのキーの配下のものは置き換わる
  Future<void> updateData(
    Map<String, dynamic> data, {
    WriteBatch batch,
    Transaction transaction,
  }) {
    assert(batch == null || transaction == null);
    if (batch == null && transaction == null) {
      return ref.updateData(data);
    }
    if (batch != null) {
      batch.updateData(ref, data);
      return null;
    }
    if (transaction != null) {
      transaction.update(ref, data);
      return null;
    }
    assert(false);
    return null;
  }

  /// 全置き換え
  Future<void> set(
    E entity, {
    WriteBatch batch,
    Transaction transaction,
  }) {
    return setData(
      collectionRef.encoder(entity),
      batch: batch,
      transaction: transaction,
    );
  }

  /// 全置き換え
  Future<void> setData(
    Map<String, dynamic> data, {
    WriteBatch batch,
    Transaction transaction,
  }) {
    assert(batch == null || transaction == null);
    if (batch == null && transaction == null) {
      return ref.setData(data);
    }
    if (batch != null) {
      batch.setData(ref, data);
      return null;
    }
    if (transaction != null) {
      transaction.set(ref, data);
      return null;
    }
    assert(false);
    return null;
  }

  /// マージ
  Future<void> merge(
    E entity, {
    WriteBatch batch,
    Transaction transaction,
  }) {
    return mergeData(
      collectionRef.encoder(entity),
      batch: batch,
      transaction: transaction,
    );
  }

  /// マージ
  Future<void> mergeData(
    Map<String, dynamic> data, {
    WriteBatch batch,
    Transaction transaction,
  }) {
    assert(batch == null || transaction == null);
    if (batch == null && transaction == null) {
      return ref.setData(data, merge: true);
    }
    if (batch != null) {
      batch.setData(ref, data, merge: true);
      return null;
    }
    if (transaction != null) {
      throw UnsupportedError(
        'Not supported currently: '
        'https://github.com/FirebaseExtended/flutterfire/issues/1212',
      );
//      transaction.set(ref, data, merge: true);
//      return null;
    }
    assert(false);
    return null;
  }

  Future<void> delete({
    WriteBatch batch,
    Transaction transaction,
  }) {
    assert(batch == null || transaction == null);
    if (batch == null && transaction == null) {
      return ref.delete();
    }
    if (batch != null) {
      batch.delete(ref);
      return null;
    }
    if (transaction != null) {
      transaction.delete(ref);
      return null;
    }
    assert(false);
    return null;
  }
}
