import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import 'collection_paging_controller.dart';
import 'document_list.dart';

// TODO(mono): pagingController対応
class CollectionGroup<E, D extends Document<E>> {
  CollectionGroup({
    @required String path,
    @required this.decoder,
    @required this.encoder,
  }) : query = Firestore.instance.collectionGroup(path);

  final Query query;
  final DocumentDecoder<D> decoder;
  final EntityEncoder<E> encoder;

  Stream<QuerySnapshot> snapshots([QueryBuilder makeQuery]) {
    return (makeQuery ?? (r) => r)(query).snapshots();
  }

  Stream<List<D>> documents([QueryBuilder makeQuery]) {
    final documentList = DocumentList<E, D>(decoder: decoder);
    return snapshots(makeQuery).map(documentList.applyingSnapshot);
  }

  Future<QuerySnapshot> getSnapshots([QueryBuilder makeQuery]) {
    return (makeQuery ?? (r) => r)(query).getDocuments();
  }

  Future<List<D>> getDocuments([QueryBuilder makeQuery]) async {
    final snapshots = await getSnapshots(makeQuery);
    return snapshots.documents.map(decoder).toList();
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
