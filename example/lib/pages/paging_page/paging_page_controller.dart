import 'package:example/pages/paging_page/paging_data.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/single_child_widget.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:subscription_holder/subscription_holder.dart';

import 'paging_page_state.dart';

export 'paging_page_state.dart';

class PagingPageController extends StateNotifier<PagingPageState>
    with LocatorMixin {
  PagingPageController() : super(PagingPageState());

  static final _collectionRef = PagingDatasRef();
  // `_collectionGroup` can be used to access pagingController
//  static final _collectionGroup = CollectionGroup(
//    decoder: _collectionRef.decoder,
//    encoder: _collectionRef.encoder,
//    path: 'pagings',
//  );
  final _sh = SubscriptionHolder();

  final _pagingController = _collectionRef.pagingController(
    // Can be omitted
    queryBuilder: (r) => r.orderBy('createdAt'),
    initialSize: 20,
    defaultPagingSize: 10,
  );

  void addDocs(int count) {
    runBatchWrite<void>((batch) async {
      for (final _ in List.generate(count, (i) => i)) {
        await _collectionRef.docRef().set(
              const PagingData(),
              batch: batch,
            );
      }
    });
  }

  Future<void> loadMore({
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    await Future<void>.delayed(delay);
    _pagingController.loadMore();
  }

  Future<void> deleteAll() async {
    logger.info('[Start] deleteAll');
    final deletedIds = await _collectionRef.deleteAllDocuments();
    logger..info('[End] deleteAll')..info('Deleted ids: $deletedIds');
  }

  void increment({@required PagingDataDoc doc}) {
    final data = doc.entity;
    _collectionRef.docRef(doc.id).merge(
          data.copyWith(
            count: data.count + 1,
          ),
        );
  }

  @override
  void initState() {
    _sh
      ..add(
        _pagingController.documents.listen((docs) {
          state = state.copyWith(
            docs: docs,
          );
        }),
      )
      ..add(
        _pagingController.hasMore.listen((hasMore) {
          state = state.copyWith(
            hasMore: hasMore,
          );
        }),
      );
  }

  @override
  void dispose() {
    _sh.dispose();

    super.dispose();
  }

  static SingleChildWidget provider({
    Widget child,
    PagingPageController value,
  }) {
    return StateNotifierProvider<PagingPageController, PagingPageState>(
      create: (context) => PagingPageController(),
      child: child,
    );
  }
}
