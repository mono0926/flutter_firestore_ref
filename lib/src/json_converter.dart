import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
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

class DocumentReferenceSetConverter
    implements JsonConverter<Set<DocumentReference>, List> {
  const DocumentReferenceSetConverter();

  @override
  Set<DocumentReference> fromJson(List json) => Set.from(json);

  @override
  List toJson(Set<DocumentReference> refs) => List<dynamic>.from(refs);
}

class DocumentReferenceSetNullableConverter
    implements JsonConverter<Set<DocumentReference>?, List?> {
  const DocumentReferenceSetNullableConverter();

  @override
  Set<DocumentReference>? fromJson(List? json) =>
      json == null ? null : Set.from(json);

  @override
  List? toJson(Set<DocumentReference>? refs) =>
      refs == null ? null : List<dynamic>.from(refs);
}

class DocumentReferenceListConverter
    implements JsonConverter<List<DocumentReference>, List> {
  const DocumentReferenceListConverter();

  @override
  List<DocumentReference> fromJson(List? json) => json?.cast() ?? [];

  @override
  List toJson(List<DocumentReference>? refs) => refs ?? <dynamic>[];
}

class DocumentReferenceListNullableConverter
    implements JsonConverter<List<DocumentReference>?, List?> {
  const DocumentReferenceListNullableConverter();

  @override
  List<DocumentReference>? fromJson(List? json) => json?.cast();

  @override
  List? toJson(List<DocumentReference>? refs) => refs;
}

class DocumentReferenceConverter
    extends PassthroughConverter<DocumentReference<JsonMap>> {
  const DocumentReferenceConverter();
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();
  @override
  Color fromJson(int json) => Color(json);
  @override
  int toJson(Color object) => object.value;
}
