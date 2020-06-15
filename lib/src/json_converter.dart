import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class PassthroughConverter<T> implements JsonConverter<T, T> {
  const PassthroughConverter();

  @override
  T fromJson(T json) => json;

  @override
  T toJson(T object) => object;
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => json?.toDate();

  @override
  Timestamp toJson(DateTime object) =>
      object == null ? null : Timestamp.fromDate(object);
}

class DocumentReferenceSetConverter
    extends JsonConverter<Set<DocumentReference>, List<DocumentReference>> {
  @override
  Set<DocumentReference> fromJson(List<DocumentReference> json) =>
      Set.from(json);

  @override
  List<DocumentReference> toJson(Set<DocumentReference> object) =>
      List.from(object);
}

class DocumentReferenceListConverter
    extends PassthroughConverter<List<DocumentReference>> {
  const DocumentReferenceListConverter();
}

class DocumentReferenceConverter
    extends PassthroughConverter<DocumentReference> {
  const DocumentReferenceConverter();
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();
  @override
  Color fromJson(int json) => Color(json);
  @override
  int toJson(Color object) => object.value;
}
