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

class ISO8601Converter implements JsonConverter<DateTime, String> {
  const ISO8601Converter();

  @override
  DateTime fromJson(String json) => json == null ? null : DateTime.parse(json);

  @override
  String toJson(DateTime object) => object?.toIso8601String();
}

class DocumentReferenceSetConverter
    implements JsonConverter<Set<DocumentReference>, List> {
  const DocumentReferenceSetConverter({
    this.emptyCollectionIfNull = true,
  });

  final bool emptyCollectionIfNull;

  @override
  Set<DocumentReference> fromJson(List json) =>
      json == null ? (emptyCollectionIfNull ? {} : null) : Set.from(json);

  @override
  List toJson(Set<DocumentReference> refs) => refs == null
      ? (emptyCollectionIfNull ? <dynamic>[] : null)
      : List<dynamic>.from(refs);
}

class DocumentReferenceListConverter
    implements JsonConverter<List<DocumentReference>, List> {
  const DocumentReferenceListConverter({
    this.emptyCollectionIfNull = true,
  });

  final bool emptyCollectionIfNull;

  @override
  List<DocumentReference> fromJson(List json) =>
      emptyCollectionIfNull ? json?.cast() ?? [] : json.cast();

  @override
  List toJson(List<DocumentReference> refs) =>
      emptyCollectionIfNull ? refs ?? <dynamic>[] : refs;
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
