import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'document_list.dart';

typedef MakeQuery = Query Function(CollectionReference collectionRef);
typedef DocumentDecoder<D extends Document<dynamic>> = D Function(
    DocumentSnapshot snapshot);
typedef EntityEncoder<E> = Map<String, dynamic> Function(
  E entity,
);

@immutable
class CollectionRef<E, D extends Document<E>> {
  CollectionRef(
    this.ref, {
    @required this.decoder,
    @required this.encoder,
  }) : _documentList = DocumentList(decoder: decoder);

  final CollectionReference ref;
  final DocumentDecoder<D> decoder;
  final EntityEncoder<E> encoder;
  final DocumentList<E, D> _documentList;

  Stream<QuerySnapshot> snapshots([MakeQuery makeQuery]) {
    return (makeQuery ?? (r) => r)(ref).snapshots();
  }

  Stream<List<D>> documents([MakeQuery makeQuery]) {
    return snapshots(makeQuery).map(_documentList.applyingSnapshot);
  }

  Future<QuerySnapshot> getSnapshots([MakeQuery makeQuery]) {
    return (makeQuery ?? (r) => r)(ref).getDocuments();
  }

  Future<List<D>> getDocuments([MakeQuery makeQuery]) async {
    final snapshots = await getSnapshots(makeQuery);
    return snapshots.documents.map(decoder).toList();
  }

  DocumentRef<E, D> docRef([String id]) {
    return DocumentRef<E, D>(
      id: id,
      collectionRef: this,
    );
  }

  Future<DocumentRef<E, D>> add(E entity) async {
    final rawRef = await ref.add(encoder(entity));
    return docRef(rawRef.documentID);
  }

  Future<void> deleteAllDocuments({
    int batchSize = 500,
  }) async {
    await _deleteQueryBatch(
      query: ref.orderBy(FieldPath.documentId).limit(batchSize),
      batchSize: batchSize,
    );
  }

  Future<void> _deleteQueryBatch({
    @required Query query,
    @required int batchSize,
  }) async {
    final snapshots = await query.getDocuments();
    final docs = snapshots.documents;
    if (docs.isEmpty) {
      return;
    }

    await runBatchWrite<void>((batch) {
      for (final doc in docs) {
        batch.delete(doc.reference);
      }
      return;
    });

    print('deleted count: ${docs.length}');

    return _deleteQueryBatch(
      query: query,
      batchSize: batchSize,
    );
  }
}
