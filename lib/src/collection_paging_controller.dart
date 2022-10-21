import 'dart:math';

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
                },
              );
              logger.info('hoge: $documentList');
              return (queryBuilder ?? (q) => q)(queryRef.query)
                  .limit(limit + 1)
                  .snapshots()
                  .map(documentList.applyingSnapshot);
            })
            .map((r) => r.list)
            .listen(_documentsForHasMoreController.add),
      )
      ..add(
        _documentsForHasMoreController.listen((docs) {
          _hasMoreController.add(docs.length > _limitController.value);
        }),
      );

    _documentsForHasMoreController.map((docs) {
      final docLength = docs.length;
      final size = min(docLength, _limitController.value);
      return size == docLength ? docs : docs.take(size).toList();
    }).pipe(_documentsController);
  }

  final int defaultPagingSize;
  final BehaviorSubject<int> _limitController;
  final _sh = SubscriptionHolder();

  final _documentsForHasMoreController = BehaviorSubject<List<D>>.seeded([]);
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
  Future<void> dispose() async {
    _sh.dispose();
    await _limitController.close();
    await _documentsController.drain<void>();
    await _documentsController.close();
    await _hasMoreController.close();
  }
}
