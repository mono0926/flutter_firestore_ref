import 'package:firestore_ref/firestore_ref.dart';

class TimestampField {
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

JsonMap replacingTimestamp({
  required JsonMap json,
}) =>
    <String, dynamic>{
      ...json,
      if (json[TimestampField.createdAt] == null)
        TimestampField.createdAt: FieldValue.serverTimestamp(),
      TimestampField.updatedAt: FieldValue.serverTimestamp(),
    };

DateTime? parseTimestamp({
  required JsonMap json,
  required String key,
}) {
  return (json[key] as Timestamp?)?.toDate();
}
