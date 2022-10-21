import 'package:example/pages/paging_page/paging_data.dart';
import 'package:example/util/util.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pagingCollectionRef = Provider((ref) => PagingDatasRef());

final pagingController = Provider.autoDispose(
  (ref) {
    final controller = ref.watch(pagingCollectionRef).pagingController(
          queryBuilder: (r) => r.orderBy('createdAt'),
          initialSize: 20,
          defaultPagingSize: 10,
        );
    ref.onDispose(controller.dispose);
    return controller;
  },
);

// TODO(mono): 過去に偶然動いてた部分が動かなくなったのを無理矢理対処したので https://github.com/mono0926/flutter_playground/blob/main/lib/paging/paging/paging_notifier.dart のようにCollectionPagingControllerを直したい
final documentsProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(pagingController).documents,
);

final pagingDocsLengthProvider = Provider.autoDispose(
  (ref) => ref.watch(documentsProvider).value?.length ?? 0,
);

final pagingDocsLengthForWidgetProvider = Provider.autoDispose(
  (ref) {
    final hasMore = ref.watch(pagingController.select((s) => s.hasMore)).value;
    return ref.watch(pagingDocsLengthProvider) + (hasMore ? 1 : 0);
  },
);

final pagingDocsModifier = Provider(PagingDocsModifier.new);

class PagingDocsModifier {
  PagingDocsModifier(this._ref);

  final Ref _ref;

  void addDocs(int count) {
    runBatchWrite<void>((batch) async {
      for (var i = 0; i < count; i++) {
        await _ref.read(pagingCollectionRef).docRefWithId().set(
              const PagingData(),
              batch: batch,
            );
      }
    });
  }

  void increment({required PagingDataDoc doc}) {
    final data = doc.entity!;
    doc.pagingDataRef.merge(
      data.copyWith(
        count: data.count + 1,
      ),
    );
  }

  Future<void> deleteAll() async {
    logger.info('[Start] deleteAll');
    final deletedIds =
        await _ref.read(pagingCollectionRef).deleteAllDocuments();
    logger
      ..info('[End] deleteAll')
      ..info('Deleted ids: $deletedIds');
  }
}

final pagingPageInfoProvider = Provider.autoDispose((ref) {
  final length = ref.watch(pagingDocsLengthProvider);
  final hasMore = ref.watch(pagingController.select((s) => s.hasMore)).value;
  return '$length / ${hasMore ? '?' : length}';
});
