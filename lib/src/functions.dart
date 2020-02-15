import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';

Future<void> runBatchWrite(Future Function(WriteBatch batch) f) async {
  final batch = Firestore.instance.batch();
  await f(batch);
  await batch.commit();
}
