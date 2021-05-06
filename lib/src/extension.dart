import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/src/document_list.dart';
import 'package:firestore_ref/src/utils.dart';

import 'collection_paging_controller.dart';
import 'firestore_operation_counter.dart';
import 'functions.dart';

extension QueryX<E> on Query<E> {
  /// Delete all documents
  ///
  /// Default value of [batchSize] is 500, which is max limit of Batch Write.
  /// Return value is deleted document references.
  Future<List<DocumentReference>> deleteAllDocuments({
    int batchSize = 500,
  }) async {
    return _deleteQueryBatch(
      query: orderBy(FieldPath.documentId).limit(batchSize),
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
      firestoreOperationCounter.recordDelete(
        count: docs.length,
      );
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
      deletedRefs: [
        ...deletedRefs,
        ...docs.map((d) => d.reference),
      ],
    );
  }

  CollectionPagingController<E> pagingController({
    int initialSize = 10,
    int defaultPagingSize = 10,
  }) {
    return CollectionPagingController(
      query: this,
      initialSize: initialSize,
      defaultPagingSize: defaultPagingSize,
    );
  }

  Stream<SnapshotCollection<E>> snapshotCollection() {
    final documentList = SnapshotHolder<E>();
    return snapshots().map(documentList.applyingSnapshot);
  }
}
