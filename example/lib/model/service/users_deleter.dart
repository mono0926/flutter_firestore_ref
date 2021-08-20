import 'package:example/model/firestore/firestore.dart';
import 'package:example/util/util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final usersDeleter = Provider((ref) => UsersDeleter(ref.read));

class UsersDeleter {
  UsersDeleter(this._read);

  final Reader _read;

  Future<void> execute() async {
    logger.info('[Start] deleteAll');
    final deletedIds = await _read(usersRefProvider).deleteAllDocuments(
      batchSize: 2,
    );
    logger
      ..info('[End] deleteAll')
      ..info('Deleted ids: $deletedIds');
  }
}
