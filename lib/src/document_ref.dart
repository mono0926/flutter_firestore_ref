import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';
import 'package:simple_logger/simple_logger.dart';

SimpleLogger get _logger => SimpleLogger();

@immutable
class DocumentRef<E extends Entity, D extends Document<E>> {
  const DocumentRef({
    @required this.ref,
    @required this.decoder,
    @required this.encoder,
  });

  final DocumentReference ref;
  final DocumentDecoder<D> decoder;
  final EntityEncoder<E> encoder;

  Stream<D> document() {
    return ref.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        _logger.warning('$D not found(id: ${ref.documentID})');
        return null;
      }
      return decoder.decode(snapshot);
    });
  }

  Future<D> get() async {
    final snapshot = await ref.get();
    if (!snapshot.exists) {
      _logger.warning('$D not found(id: ${ref.documentID})');
      return null;
    }
    return decoder.decode(snapshot);
  }

  /// すでにあるデータに対して
  /// マージと似ているがそのキーの配下のものは置き換わる
  Future<void> update(E entity, {WriteBatch batch}) {
    return updateData(encoder.encode(entity), batch: batch);
  }

  /// すでにあるデータに対して
  /// マージと似ているがそのキーの配下のものは置き換わる
  Future<void> updateData(Map<String, dynamic> data, {WriteBatch batch}) {
    if (batch == null) {
      return ref.updateData(data);
    } else {
      batch.updateData(ref, data);
      return Future.value(null);
    }
  }

  /// 全置き換え
  Future<void> set(E entity, {WriteBatch batch}) {
    return setData(
      encoder.encode(entity),
      batch: batch,
    );
  }

  /// 全置き換え
  Future<void> setData(Map<String, dynamic> data, {WriteBatch batch}) {
    if (batch == null) {
      return ref.setData(data);
    } else {
      batch.setData(ref, data);
      return Future.value(null);
    }
  }

  /// マージ
  Future<void> merge(E entity, {WriteBatch batch}) {
    return mergeData(
      encoder.encode(entity),
      batch: batch,
    );
  }

  /// マージ
  Future<void> mergeData(Map<String, dynamic> data, {WriteBatch batch}) {
    if (batch == null) {
      return ref.setData(data, merge: true);
    } else {
      batch.setData(ref, data, merge: true);
      return Future.value(null);
    }
  }

  Future<void> delete({WriteBatch batch}) {
    if (batch == null) {
      return ref.delete();
    } else {
      batch.delete(ref);
      return Future.value(null);
    }
  }
}
