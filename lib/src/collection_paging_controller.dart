import 'package:disposable_provider/disposable_provider.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:subscription_holder/subscription_holder.dart';

import 'document_list.dart';

class CollectionPagingController<E, D extends Document<E>,
    DocRef extends DocumentRef<E, D>> with Disposable {
  CollectionPagingController({
    required QueryRef<E, D, DocRef> queryRef,
    @required QueryBuilder? queryBuilder,
    required int initialSize,
    required this.defaultPagingSize,
  }) : _limitController = BehaviorSubject.seeded(initialSize) {
    _sh
      ..add(
        _limitController.stream
            .switchMap((limit) {
              final documentList = DocumentList<E, D, DocRef>(
                  docRefCreator: queryRef.docRef,
                  decoder: (snapshot, docRef) {
                    final cached = _documentsCache[snapshot.reference.path];
                    if (cached != null && snapshot.metadata.isFromCache) {
                      // logger.fine('cache hit (id: ${cached.id})');
                      return cached;
                    }
                    final doc = queryRef.decode(snapshot, docRef);
                    _documentsCache[snapshot.reference.path] = doc;
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
        Rx.combineLatest2(
                _documentsController.map((docs) => docs.length),
                _limitController,
                (int docLength, int limit) => docLength >= limit)
            .listen(_hasMoreController.add),
      );
  }

  final int defaultPagingSize;
  final BehaviorSubject<int> _limitController;
  final _sh = SubscriptionHolder();

  final _documentsController = BehaviorSubject<List<D>>.seeded([]);
  final _hasMoreController = BehaviorSubject<bool>.seeded(true);
  // After https://github.com/FirebaseExtended/flutterfire/pull/3263 fixed, change key type to DocumentReference
  final _documentsCache = <String, D>{};

  ValueStream<List<D>> get documents => _documentsController.stream;
  ValueStream<bool> get hasMore => _hasMoreController.stream;

  bool loadMore({int? pagingSize}) {
    final hasMore = this.hasMore.value;
    if (hasMore) {
      _limitController.add(
        _limitController.value + (pagingSize ?? defaultPagingSize),
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
