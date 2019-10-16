import 'package:firestore_ref/firestore_ref.dart';

Future<void> runBatchWrite(Future Function(WriteBatch batch) f) async {
  final batch = firestoreInstance.batch();
  await f(batch);
  await batch.commit();
}
