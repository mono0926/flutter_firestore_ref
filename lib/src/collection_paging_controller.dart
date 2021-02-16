import 'package:disposable_provider/disposable_provider.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:firestore_ref/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:subscription_holder/subscription_holder.dart';

import 'document_list.dart';

class CollectionPagingController<E, D extends Document<E>,
    DocRef extends DocumentRef<E, D>> with Disposable {
  CollectionPagingController({
    @required QueryRef<E, D, DocRef> queryRef,
    @required QueryBuilder queryBuilder,
    @required int initialSize,
    @required this.defaultPagingSize,
  })  : assert(initialSize != null),
        _limitController = BehaviorSubject.seeded(initialSize) {
    _sh
      ..add(
        _limitController.stream
            .switchMap((limit) {
              final documentList = DocumentList<E, D, DocRef>(
                  docRefCreator: queryRef.docRef,
                  decoder: (snapshot, docRef) {
                    assert(docRef != null);
                    final cached = _documentsCache[snapshot.reference];
                    if (cached != null && snapshot.metadata.isFromCache) {
                      logger.fine('cache hit (id: ${cached.id})');
                      return cached;
                    }
                    final doc = queryRef.decode(snapshot, docRef);
                    _documentsCache[snapshot.reference] = doc;
                    return doc;
                  });
              return (queryBuilder ?? (q) => q)(queryRef.query)
                  .limit(limit)
                  .snapshots()
                  .map(documentList.applyingSnapshot);
            })
            .map((r) => r.list)
            .listen(_documentsController.add),
      )
      ..add(
        _documentsController
            .map((documents) => documents.length >= _limitController.value)
            .listen(_hasMoreController.add),
      );
  }

  final int defaultPagingSize;
  final BehaviorSubject<int> _limitController;
  final _sh = SubscriptionHolder();

  final _documentsController = BehaviorSubject<List<D>>.seeded([]);
  final _hasMoreController = BehaviorSubject<bool>.seeded(true);
  final _documentsCache = <DocumentReference, D>{};

  ValueStream<List<D>> get documents => _documentsController.stream;
  ValueStream<bool> get hasMore => _hasMoreController.stream;

  bool loadMore({int pagingSize}) {
    final hasMore = this.hasMore.value;
    if (hasMore) {
      _limitController.add(
        _limitController.requireValue + pagingSize ?? defaultPagingSize,
      );
    }
    return hasMore;
  }

  @override
  void dispose() {
    _sh.dispose();
    _limitController.close();
    _documentsController.close();
    _hasMoreController.close();
  }
}
