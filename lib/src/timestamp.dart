import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

class TimestampField {
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

Map<String, dynamic> replacingTimestamp({
  @required Map<String, dynamic> json,
}) =>
    <String, dynamic>{
      ...json,
      if (json[TimestampField.createdAt] == null)
        TimestampField.createdAt: FieldValue.serverTimestamp(),
      TimestampField.updatedAt: FieldValue.serverTimestamp(),
    };

DateTime parseTimestamp({
  @required Map<String, dynamic> json,
  @required String key,
}) {
  return (json[key] as Timestamp)?.toDate();
}
