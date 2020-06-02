import 'package:disposable_provider/disposable_provider.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:firestore_ref/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'document_list.dart';

class CollectionPagingController<E, D extends Document<E>> with Disposable {
  CollectionPagingController({
    @required CollectionRef<E, D> ref,
    QueryBuilder queryBuilder,
    int initialSize = 10,
    this.defaultPagingSize = 10,
  }) {
    _limitController.stream.switchMap((limit) {
      final documentList = DocumentList<E, D>(decoder: (snapshot) {
        final cached = _documentsCache[snapshot.reference];
        if (cached != null && snapshot.metadata.isFromCache) {
          logger.info('cache hit (id: ${cached.id})');
          return cached;
        }
        final doc = ref.decoder(snapshot);
        _documentsCache[snapshot.reference] = doc;
        return doc;
      });
      return ref
          .snapshots((r) => (queryBuilder ?? (r) => r)(r).limit(limit))
          .map(documentList.applyingSnapshot);
    }).pipe(_documentsController);

    _limitController.add(initialSize);

    _documentsController
        .map((documents) => documents.length >= _limitController.value)
        .pipe(_hasMoreController);
  }

  final int defaultPagingSize;

  final _documentsController = BehaviorSubject<List<D>>.seeded([]);
  final _limitController = BehaviorSubject<int>();
  final _hasMoreController = BehaviorSubject<bool>.seeded(true);
  final _documentsCache = <DocumentReference, D>{};

  ValueStream<List<D>> get documents => _documentsController.stream;
  ValueStream<bool> get hasMore => _hasMoreController.stream;

  bool loadMore({int pagingSize}) {
    if (!hasMore.value) {
      return false;
    }
    _limitController.add(
      _limitController.value + (pagingSize ?? defaultPagingSize),
    );
    return true;
  }

  @override
  void dispose() {
    _limitController.close();
    _documentsController.close();
    _hasMoreController.close();
  }
}
