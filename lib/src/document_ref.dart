import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';
import 'package:simple_logger/simple_logger.dart';

import 'firestore.dart';

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
    return documentRefToSnapshots(ref).map((snapshot) {
      if (!snapshot.exists) {
        _logger.warning('$D not found(id: ${getDocumentId(ref)})');
        return null;
      }
      return decoder.decode(snapshot);
    });
  }

  Future<D> get() async {
    final snapshot = await ref.get();
    if (!snapshot.exists) {
      _logger.warning('$D not found(id: ${getDocumentId(ref)})');
      return null;
    }
    return decoder.decode(snapshot);
  }

  /// すでにあるデータに対して
  /// マージと似ているがそのキーの配下のものは置き換わる
  Future<void> update(E entity, {WriteBatch batch}) {
    return updateJson(encoder.encode(entity), batch: batch);
  }

  /// すでにあるデータに対して
  /// マージと似ているがそのキーの配下のものは置き換わる
  Future<void> updateJson(Map<String, dynamic> json, {WriteBatch batch}) {
    return updateRef(ref, data: json, batch: batch);
  }

  /// 全置き換え
  Future<void> set(E entity, {WriteBatch batch}) {
    return setJson(
      encoder.encode(entity),
      batch: batch,
    );
  }

  /// 全置き換え
  Future<void> setJson(Map<String, dynamic> json, {WriteBatch batch}) {
    return setRef(
      ref,
      data: json,
      batch: batch,
    );
  }

  /// マージ
  Future<void> merge(E entity, {WriteBatch batch}) {
    return mergeJson(
      encoder.encode(entity),
      batch: batch,
    );
  }

  /// マージ
  Future<void> mergeJson(Map<String, dynamic> json, {WriteBatch batch}) {
    return setRef(
      ref,
      data: json,
      batch: batch,
      merge: true,
    );
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
