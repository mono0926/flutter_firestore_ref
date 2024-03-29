import 'package:firestore_ref/firestore_ref.dart';
import 'package:json_converter_helper/json_converter_helper.dart';
import 'package:quiver/iterables.dart';

Future<T> runBatchWrite<T>(Future<T> Function(WriteBatch batch) f) async {
  final batch = FirebaseFirestore.instance.batch();
  final result = await f(batch);
  await batch.commit();
  return result;
}

Future<void> deleteDocuments({
  required List<DocumentReference> references,
  int batchSize = 500,
}) {
  return Future.wait(
    partition(references, batchSize).map(
      (chunked) => runBatchWrite<void>((batch) {
        chunked.forEach(batch.delete);
        return Future.value();
      }),
    ),
  );
}

JsonMap? parseJson(
  JsonMap json, {
  required String key,
}) {
  final value = json[key] as Map?;
  return value == null ? null : Map<String, dynamic>.from(value);
}

T? parse<T>(
  JsonMap json, {
  required String key,
  required T Function(JsonMap) fromJson,
}) {
  final parsedJson = parseJson(json, key: key);
  return parsedJson == null ? null : fromJson(parsedJson);
}
