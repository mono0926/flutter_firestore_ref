import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:quiver/iterables.dart';

Future<T> runBatchWrite<T>(Future<T> Function(WriteBatch batch) f) async {
  final batch = FirebaseFirestore.instance.batch();
  final result = await f(batch);
  await batch.commit();
  return result;
}

Future<void> deleteDocuments({
  @required List<DocumentReference> references,
  int batchSize = 500,
}) {
  return Future.wait(
    partition(references, batchSize).map(
      (chunked) => runBatchWrite<void>((batch) {
        chunked.forEach(batch.delete);
        return;
      }),
    ),
  );
}

Map<String, dynamic> parseJson(
  Map<String, dynamic> json, {
  @required String key,
}) {
  final value = json[key] as Map;
  return value == null ? null : Map<String, dynamic>.from(value);
}

T parse<T>(
  Map<String, dynamic> json, {
  @required String key,
  @required T Function(Map<String, dynamic>) fromJson,
}) {
  final parsedJson = parseJson(json, key: key);
  return parsedJson == null ? null : fromJson(parsedJson);
}
