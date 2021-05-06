import 'package:disposable_provider/disposable_provider.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:rxdart/rxdart.dart';
import 'package:subscription_holder/subscription_holder.dart';

import 'document_list.dart';

class CollectionPagingController<E> with Disposable {
  CollectionPagingController({
    required Query<E> query,
    required int initialSize,
    required this.defaultPagingSize,
  }) : _limitController = BehaviorSubject.seeded(initialSize) {
    _sh
      ..add(
        _limitController.stream
            .switchMap((limit) {
              return query.limit(limit).snapshots();
            })
            .map((snapshot) => snapshot.docs)
            .listen(_documentsController.add),
      )
      ..add(
        _documentsController
            .map((documents) =>
                documents.length >= _limitController.requireValue)
            .listen(_hasMoreController.add),
      );
  }

  final int defaultPagingSize;
  final BehaviorSubject<int> _limitController;
  final _sh = SubscriptionHolder();

  final _documentsController =
      BehaviorSubject<List<DocumentSnapshot<E>>>.seeded([]);
  final _hasMoreController = BehaviorSubject<bool>.seeded(true);

  ValueStream<List<DocumentSnapshot<E>>> get documents =>
      _documentsController.stream;
  ValueStream<bool> get hasMore => _hasMoreController.stream;

  bool loadMore({int? pagingSize}) {
    final hasMore = this.hasMore.hasValue;
    if (hasMore) {
      _limitController.add(
        _limitController.requireValue + (pagingSize ?? defaultPagingSize),
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
