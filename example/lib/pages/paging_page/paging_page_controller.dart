import 'package:example/pages/paging_page/paging_data.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:subscription_holder/subscription_holder.dart';

import 'paging_page_state.dart';

export 'paging_page_state.dart';

final pagingPageController =
    StateNotifierProvider.autoDispose<PagingPageController, PagingPageState>(
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

  // `_collectionGroup` can be used to access pagingController
//  static final _collectionGroup = CollectionGroup(
//    decoder: _collectionRef.decoder,
//    encoder: _collectionRef.encoder,
//    path: 'pagings',
//  );
  final _sh = SubscriptionHolder();

  final _pagingController =
      pagingDatasRef.orderBy('createdAt').pagingController(
            initialSize: 20,
            defaultPagingSize: 10,
          );

  void addDocs(int count) {
    runBatchWrite<void>((batch) async {
      for (final _ in List.generate(count, (i) => i)) {
        batch.set(
          pagingDatasRef.doc(),
          const PagingData(),
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
    final deletedIds = await pagingDatasRef.deleteAllDocuments();
    logger..info('[End] deleteAll')..info('Deleted ids: $deletedIds');
  }

  void increment({required DocumentSnapshot<PagingData> doc}) {
    final data = doc.data()!;
    doc.reference.set(
      data.copyWith(
        count: data.count + 1,
      ),
      SetOptions(merge: true),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _sh.dispose();

    super.dispose();
  }
}
