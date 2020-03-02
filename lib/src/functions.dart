import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

Future<void> runBatchWrite(Future Function(WriteBatch batch) f) async {
  final batch = Firestore.instance.batch();
  await f(batch);
  await batch.commit();
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

Future<T> executeBatch<T>(Future<T> Function(WriteBatch batch) f) async {
  final batch = Firestore.instance.batch();
  final result = await f(batch);
  await batch.commit();
  return result;
}
