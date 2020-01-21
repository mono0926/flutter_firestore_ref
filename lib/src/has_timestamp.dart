import 'package:firestore_ref/firestore_ref.dart';

mixin HasTimestamp {
  DateTime get createdAt;
  DateTime get updatedAt;

  Map<String, dynamic> get timestampJson => <String, dynamic>{
        if (createdAt == null)
          TimestampField.createdAt: FieldValue.serverTimestamp(),
        TimestampField.updatedAt: FieldValue.serverTimestamp(),
      };

  static DateTime parseCreatedAt(Map<String, dynamic> json) {
    return parseTimestamp(json: json, key: TimestampField.createdAt);
  }

  static DateTime parseUpdatedAt(Map<String, dynamic> json) {
    return parseTimestamp(json: json, key: TimestampField.updatedAt);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HasTimestamp &&
          runtimeType == other.runtimeType &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => createdAt.hashCode ^ updatedAt.hashCode;
}

class TimestampField {
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}
