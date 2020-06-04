import 'package:disposable_provider/disposable_provider.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:firestore_ref/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'document_list.dart';

class CollectionPagingController<E, D extends Document<E>> with Disposable {
  CollectionPagingController({
    @required Query query,
    @required DocumentDecoder<D> decoder,
    @required QueryBuilder queryBuilder,
    @required int initialSize,
    @required this.defaultPagingSize,
  })  : assert(initialSize != null),
        _limitController = BehaviorSubject.seeded(initialSize) {
    _limitController.stream
        .switchMap((limit) {
          final documentList = DocumentList<E, D>(decoder: (snapshot) {
            final cached = _documentsCache[snapshot.reference];
            if (cached != null && snapshot.metadata.isFromCache) {
              logger.fine('cache hit (id: ${cached.id})');
              return cached;
            }
            final doc = decoder(snapshot);
            _documentsCache[snapshot.reference] = doc;
            return doc;
          });
          return (queryBuilder ?? (q) => q)(query)
              .limit(limit)
              .snapshots()
              .map(documentList.applyingSnapshot);
        })
        .map((r) => r.list)
        .pipe(_documentsController);

    _documentsController
        .map((documents) => documents.length >= _limitController.value)
        .pipe(_hasMoreController);
  }

  final int defaultPagingSize;
  final BehaviorSubject<int> _limitController;

  final _documentsController = BehaviorSubject<List<D>>.seeded([]);
  final _hasMoreController = BehaviorSubject<bool>.seeded(true);
  final _documentsCache = <DocumentReference, D>{};

  ValueStream<List<D>> get documents => _documentsController.stream;
  ValueStream<bool> get hasMore => _hasMoreController.stream;

  bool loadMore({int pagingSize}) {
    final hasMore = this.hasMore.value;
    if (hasMore) {
      _limitController.value += pagingSize ?? defaultPagingSize;
    }
    return hasMore;
  }

  @override
  Future<void> dispose() async {
    await _limitController.close();
    await _documentsController.drain<void>();
    await _documentsController.close();
    await _hasMoreController.close();
  }
}
