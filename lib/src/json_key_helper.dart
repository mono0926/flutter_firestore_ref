import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

DateTime dateFromTimestampValue(dynamic value) =>
    (value as Timestamp)?.toDate();

Timestamp timestampFromDateValue(dynamic value) =>
    value is DateTime ? Timestamp.fromDate(value) : null;

const timestampJsonKey = JsonKey(
  fromJson: dateFromTimestampValue,
  toJson: timestampFromDateValue,
);

Set<DocumentReference> documentReferenceSetFromListValue(dynamic value) {
  return Set.from(
      (value as List).cast<DocumentReference>() ?? <DocumentReference>[]);
}

List<DocumentReference> documentReferenceListFromSetValue(dynamic value) {
  return List.from(
      (value as Set).cast<DocumentReference>() ?? <DocumentReference>{});
}

List<DocumentReference> documentReferenceListFromListValue(dynamic value) {
  return (value as List).cast();
}

const documentReferenceSetJsonKey = JsonKey(
  fromJson: documentReferenceSetFromListValue,
  toJson: documentReferenceListFromSetValue,
);

const documentReferenceListJsonKey = JsonKey(
  fromJson: documentReferenceListFromListValue,
  toJson: documentReferenceListFromListValue,
);
