import 'package:firestore_ref/firestore_ref.dart';

Future<void> runBatchWrite(Future Function(WriteBatch batch) f) async {
  final batch = getBatch();
  await f(batch);
  await batch.commit();
}
