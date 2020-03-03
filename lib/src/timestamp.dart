import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

class TimestampField {
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

Map<String, dynamic> replacingTimestamp({
  @required Map<String, dynamic> json,
  @required DateTime createdAt,
}) =>
    <String, dynamic>{
      ...json..remove(TimestampField.createdAt),
      if (createdAt == null)
        TimestampField.createdAt: FieldValue.serverTimestamp(),
      if (json.containsKey(TimestampField.updatedAt))
        TimestampField.updatedAt: FieldValue.serverTimestamp(),
    };

DateTime parseTimestamp({
  @required Map<String, dynamic> json,
  @required String key,
}) {
  return (json[key] as Timestamp)?.toDate();
}
