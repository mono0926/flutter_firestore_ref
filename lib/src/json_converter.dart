import 'dart:ui';

import 'package:firestore_ref/firestore_ref.dart';
import 'package:json_annotation/json_annotation.dart';

class PassthroughConverter<T> implements JsonConverter<T, Object?> {
  const PassthroughConverter();

  @override
  T fromJson(Object? json) => json as T;

  @override
  Object? toJson(T object) => object;
}

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

class ISO8601Converter implements JsonConverter<DateTime?, String?> {
  const ISO8601Converter();

  @override
  DateTime? fromJson(String? json) =>
      json == null ? null : DateTime?.parse(json);

  @override
  String? toJson(DateTime? object) => object?.toIso8601String();
}

class DocumentReferenceConverter
    extends PassthroughConverter<DocumentReference<JsonMap>> {
  const DocumentReferenceConverter();
}

class DocumentReferenceNullableConverter
    extends PassthroughConverter<DocumentReference<JsonMap>?> {
  const DocumentReferenceNullableConverter();
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();
  @override
  Color fromJson(int json) => Color(json);
  @override
  int toJson(Color object) => object.value;
}
