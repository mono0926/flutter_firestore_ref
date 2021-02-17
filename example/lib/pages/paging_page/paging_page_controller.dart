import 'package:example/pages/paging_page/paging_data.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:subscription_holder/subscription_holder.dart';

import 'paging_page_state.dart';

export 'paging_page_state.dart';

final pagingPageController = StateNotifierProvider.autoDispose(
  (ref) => PagingPageController(),
);

class PagingPageController extends StateNotifier<PagingPageState> {
  PagingPageController() : super(PagingPageState()) {
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
        await _collectionRef.docRefWithId().set(
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

  void increment({required PagingDataDoc doc}) {
    final data = doc.entity!;
    doc.pagingDataRef.merge(
      data.copyWith(
        count: data.count + 1,
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _sh.dispose();

    super.dispose();
  }
}
