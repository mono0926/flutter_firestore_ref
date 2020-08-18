import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import 'collection_paging_controller.dart';
import 'document_list.dart';

class CollectionGroup<E, D extends Document<E>> {
  CollectionGroup({
    @required String path,
    @required this.decoder,
    @required this.encoder,
  }) : query = FirebaseFirestore.instance.collectionGroup(path);

  final Query query;
  final DocumentDecoder<D> decoder;
  final EntityEncoder<E> encoder;

  Stream<QuerySnapshot> snapshots([QueryBuilder queryBuilder]) {
    return (queryBuilder ?? (r) => r)(query).snapshots();
  }

  Stream<List<D>> documents([QueryBuilder queryBuilder]) {
    return documentListResult(queryBuilder).map((r) => r.list);
  }

  Stream<Map<DocumentReference, D>> documentMap([QueryBuilder queryBuilder]) {
    return documentListResult(queryBuilder).map((r) => r.map);
  }

  Stream<DocumentListResult<D>> documentListResult(
      [QueryBuilder queryBuilder]) {
    final documentList = DocumentList<E, D>(decoder: decoder);
    return snapshots(queryBuilder).map(documentList.applyingSnapshot);
  }

  Future<QuerySnapshot> getSnapshots([QueryBuilder queryBuilder]) async {
    final result = await (queryBuilder ?? (r) => r)(query).get();
    if (recordFirestoreOperationCount) {
      final count = result.docs.length;
      FirestoreOperationCounter.instance.recordRead(
        isFromCache: result.metadata.isFromCache,
        count: count,
      );
    }
    return result;
  }

  Future<List<D>> getDocuments([QueryBuilder queryBuilder]) async {
    final snapshots = await getSnapshots(queryBuilder);
    return snapshots.docs.map(decoder).toList();
  }

  CollectionPagingController<E, D> pagingController({
    QueryBuilder queryBuilder,
    int initialSize = 10,
    int defaultPagingSize = 10,
  }) {
    return CollectionPagingController(
      query: query,
      decoder: decoder,
      queryBuilder: queryBuilder,
      initialSize: initialSize,
      defaultPagingSize: defaultPagingSize,
    );
  }
}

class DocumentListResult<D> {
  DocumentListResult({
    @required this.list,
    @required this.map,
  });

  final List<D> list;
  final Map<DocumentReference, D> map;
}
