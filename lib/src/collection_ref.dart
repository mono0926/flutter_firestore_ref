import 'package:firestore_ref/firestore_ref.dart';
import 'package:firestore_ref/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_converter_helper/json_converter_helper.dart';
import 'package:meta/meta.dart';

import 'collection_paging_controller.dart';
import 'document_list.dart';

typedef QueryBuilder = Query<JsonMap> Function(Query<JsonMap> collectionRef);
typedef DocumentDecoder<
  E,
  D extends Document<E>,
  DocRef extends DocumentRef<E, D>
> = D Function(DocumentSnapshot<JsonMap> snapshot, DocRef docRef);
typedef DocRefCreator<
  E,
  D extends Document<E>,
  DocRef extends DocumentRef<E, D>
> = DocRef Function(DocumentReference<JsonMap> ref);

@immutable
abstract class QueryRef<
  E,
  D extends Document<E>,
  DocRef extends DocumentRef<E, D>
> {
  const QueryRef(this.query);

  final Query<JsonMap> query;

  D decode(DocumentSnapshot<JsonMap> snapshot, DocRef docRef);

  DocRef docRef(DocumentReference<JsonMap> ref);

  JsonMap encode(E data);

  Stream<QuerySnapshot<JsonMap>> snapshots([QueryBuilder? queryBuilder]) {
    return (queryBuilder ?? (r) => r)(query).snapshots();
  }

  Stream<List<D>> documents([QueryBuilder? queryBuilder]) {
    return documentListResult(queryBuilder).map((r) => r.list);
  }

  Stream<Map<DocRef, D>> documentMap([QueryBuilder? queryBuilder]) {
    return documentListResult(queryBuilder).map((r) => r.map);
  }

  Stream<DocumentListResult<E, D, DocRef>> documentListResult([
    QueryBuilder? queryBuilder,
  ]) {
    final documentList = DocumentList<E, D, DocRef>(
      docRefCreator: docRef,
      decoder: decode,
    );
    return snapshots(queryBuilder).map(documentList.applyingSnapshot);
  }

  Future<QuerySnapshot<JsonMap>> getSnapshots([
    QueryBuilder? queryBuilder,
    GetOptions? options,
  ]) async {
    final result = await (queryBuilder ?? (r) => r)(query).get(options);
    if (firestoreOperationCounter.enabled) {
      final count = result.docs.length;
      firestoreOperationCounter.recordRead(
        isFromCache: result.metadata.isFromCache,
        count: count,
      );
    }
    return result;
  }

  Future<List<D>> getDocuments([QueryBuilder? queryBuilder]) async {
    final snapshots = await getSnapshots(queryBuilder);
    return snapshots.docs
        .map((snap) => decode(snap, docRef(snap.reference)))
        .toList();
  }

  CollectionPagingController<E, D, DocRef> pagingController({
    QueryBuilder? queryBuilder,
    int initialSize = 10,
    int defaultPagingSize = 10,
  }) {
    return CollectionPagingController(
      queryRef: this,
      queryBuilder: queryBuilder,
      initialSize: initialSize,
      defaultPagingSize: defaultPagingSize,
    );
  }

  /// Delete all documents
  ///
  /// Default value of [batchSize] is 500, which is max limit of Batch Write.
  /// Return value is deleted document references.
  Future<List<DocumentReference>> deleteAllDocuments({int batchSize = 500}) {
    return _deleteQueryBatch(
      query: query.orderBy(FieldPath.documentId).limit(batchSize),
      batchSize: batchSize,
      deletedRefs: [],
    );
  }

  Future<List<DocumentReference>> _deleteQueryBatch({
    required Query query,
    required int batchSize,
    required List<DocumentReference> deletedRefs,
  }) async {
    final snapshots = await query.get();
    final docs = snapshots.docs;
    if (docs.isEmpty) {
      return deletedRefs;
    }

    if (firestoreOperationCounter.enabled) {
      firestoreOperationCounter.recordDelete(count: docs.length);
    }

    await runBatchWrite<void>((batch) {
      for (final doc in docs) {
        batch.delete(doc.reference);
      }
      return Future.value();
    });

    logger.fine('deleted count: ${docs.length}');

    return _deleteQueryBatch(
      query: query,
      batchSize: batchSize,
      deletedRefs: [...deletedRefs, ...docs.map((d) => d.reference)],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueryRef &&
          runtimeType == other.runtimeType &&
          query == other.query;

  @override
  int get hashCode => query.hashCode;
}

@immutable
abstract class CollectionGroupRef<
  E,
  D extends Document<E>,
  DocRef extends DocumentRef<E, D>
>
    extends QueryRef<E, D, DocRef> {
  CollectionGroupRef(String collectionPath)
    : super(FirebaseFirestore.instance.collectionGroup(collectionPath));
}

@immutable
abstract class CollectionRef<
  E,
  D extends Document<E>,
  DocRef extends DocumentRef<E, D>
>
    extends QueryRef<E, D, DocRef> {
  const CollectionRef(this.ref) : super(ref);

  final CollectionReference<JsonMap> ref;

  DocRef docRefWithId([String? id]) {
    return docRef(ref.doc(id));
  }

  Future<DocRef> add(E entity) async {
    final rawRef = await ref.add(encode(entity));
    return docRef(rawRef);
  }
}

class DocumentListResult<
  E,
  D extends Document<E>,
  DocRef extends DocumentRef<E, D>
> {
  DocumentListResult({required this.list, required this.map});
  DocumentListResult.empty() : this(list: [], map: {});

  final List<D> list;
  final Map<DocRef, D> map;

  bool get isEmpty => list.isEmpty && map.isEmpty;
}
