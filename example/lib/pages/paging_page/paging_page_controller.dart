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

final pagingDocsProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(pagingController).documents,
);

final pagingDocsLengthProvider = Provider.autoDispose(
  (ref) => ref.watch(pagingDocsProvider).value?.length ?? 0,
);

final pagingDocsLengthForWidgetProvider = Provider.autoDispose(
  (ref) {
    final hasMore = ref.watch(pagingHasMoreProvider).value ?? false;
    return ref.watch(pagingDocsLengthProvider) + (hasMore ? 1 : 0);
  },
);

final pagingHasMoreProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(pagingController).hasMore,
);

final pagingDocsModifier = Provider((ref) => PagingDocsModifier(ref.read));

class PagingDocsModifier {
  PagingDocsModifier(this._read);

  final Reader _read;

  void addDocs(int count) {
    runBatchWrite<void>((batch) async {
      for (final _ in List.generate(count, (i) => i)) {
        await _read(pagingCollectionRef).docRefWithId().set(
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
    final deletedIds = await _read(pagingCollectionRef).deleteAllDocuments();
    logger
      ..info('[End] deleteAll')
      ..info('Deleted ids: $deletedIds');
  }
}

final pagingPageInfoProvider = Provider.autoDispose((ref) {
  final length = ref.watch(pagingDocsLengthProvider);
  final hasMore = ref.watch(pagingHasMoreProvider).value ?? false;
  return '$length / ${hasMore ? '?' : length}';
});
