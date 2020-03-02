import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => json?.toDate();

  @override
  Timestamp toJson(DateTime object) =>
      object == null ? null : Timestamp.fromDate(object);
}

Set<DocumentReference> documentReferenceSetFromListValue(dynamic value) {
  return value == null
      ? null
      : Set.from((value as List).cast<DocumentReference>());
}

List<DocumentReference> documentReferenceListFromSetValue(dynamic value) {
  return value == null
      ? null
      : List.from((value as Set).cast<DocumentReference>());
}

List<DocumentReference> documentReferenceListFromListValue(dynamic value) {
  return value == null ? null : (value as List).cast();
}

const documentReferenceSetJsonKey = JsonKey(
  fromJson: documentReferenceSetFromListValue,
  toJson: documentReferenceListFromSetValue,
);

const documentReferenceListJsonKey = JsonKey(
  fromJson: documentReferenceListFromListValue,
  toJson: documentReferenceListFromListValue,
);

class DocumentReferenceConverter
    extends PassthroughConverter<DocumentReference> {
  const DocumentReferenceConverter();
}

class PassthroughConverter<T> implements JsonConverter<T, T> {
  const PassthroughConverter();

  @override
  T fromJson(T json) => json;

  @override
  T toJson(T object) => object;
}
