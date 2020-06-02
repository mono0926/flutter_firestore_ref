import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:firestore_ref/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'collection_paging_controller.dart';
import 'document_list.dart';

typedef QueryBuilder = Query Function(Query collectionRef);
typedef DocumentDecoder<D extends Document<dynamic>> = D Function(
    DocumentSnapshot snapshot);
typedef EntityEncoder<E> = Map<String, dynamic> Function(
  E entity,
);

@immutable
class CollectionRef<E, D extends Document<E>> {
  const CollectionRef(
    this.ref, {
    @required this.decoder,
    @required this.encoder,
  });

  final CollectionReference ref;
  final DocumentDecoder<D> decoder;
  final EntityEncoder<E> encoder;

  Stream<QuerySnapshot> snapshots([QueryBuilder queryBuilder]) {
    return (queryBuilder ?? (r) => r)(ref).snapshots();
  }

  Stream<List<D>> documents([QueryBuilder queryBuilder]) {
    final documentList = DocumentList<E, D>(decoder: decoder);
    return snapshots(queryBuilder).map(documentList.applyingSnapshot);
  }

  Future<QuerySnapshot> getSnapshots([QueryBuilder queryBuilder]) {
    return (queryBuilder ?? (r) => r)(ref).getDocuments();
  }

  Future<List<D>> getDocuments([QueryBuilder queryBuilder]) async {
    final snapshots = await getSnapshots(queryBuilder);
    return snapshots.documents.map(decoder).toList();
  }

  CollectionPagingController<E, D> pagingController({
    QueryBuilder queryBuilder,
    int initialSize = 10,
    int defaultPagingSize = 10,
  }) {
    return CollectionPagingController(
      query: ref,
      decoder: decoder,
      queryBuilder: queryBuilder,
      initialSize: initialSize,
      defaultPagingSize: defaultPagingSize,
    );
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

  /// Delete all documents
  ///
  /// Default value of [batchSize] is 500, which is max limit of Batch Write.
  /// Return value is deleted document references.
  Future<List<DocumentReference>> deleteAllDocuments({
    int batchSize = 500,
  }) async {
    return _deleteQueryBatch(
      query: ref.orderBy(FieldPath.documentId).limit(batchSize),
      batchSize: batchSize,
      deletedRefs: [],
    );
  }

  Future<List<DocumentReference>> _deleteQueryBatch({
    @required Query query,
    @required int batchSize,
    @required List<DocumentReference> deletedRefs,
  }) async {
    final snapshots = await query.getDocuments();
    final docs = snapshots.documents;
    if (docs.isEmpty) {
      return deletedRefs;
    }

    await runBatchWrite<void>((batch) {
      for (final doc in docs) {
        batch.delete(doc.reference);
      }
      return;
    });

    logger.fine('deleted count: ${docs.length}');

    return _deleteQueryBatch(
      query: query,
      batchSize: batchSize,
      deletedRefs: [
        ...deletedRefs,
        ...docs.map((d) => d.reference),
      ],
    );
  }
}
