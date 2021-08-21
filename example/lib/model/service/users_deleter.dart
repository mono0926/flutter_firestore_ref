import 'package:example/model/firestore/firestore.dart';
import 'package:example/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final usersDeleter = Provider((ref) {
  final read = ref.read;
  return () async {
    logger.info('[Start] deleteAll');
    final deletedIds = await read(usersRefProvider).deleteAllDocuments(
      batchSize: 2,
    );
    logger
      ..info('[End] deleteAll')
      ..info('Deleted ids: $deletedIds');
  };
});
