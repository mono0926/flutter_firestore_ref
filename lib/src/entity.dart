import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

@immutable
abstract class Entity {
  const Entity({
    this.createdAt,
    this.updatedAt,
  });
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> get timestampJson => <String, dynamic>{
        if (createdAt == null)
          EntityField.createdAt: FieldValue.serverTimestamp(),
        EntityField.updatedAt: FieldValue.serverTimestamp(),
      };
}

@immutable
// ignore: one_member_abstracts
abstract class EntityEncoder<E extends Entity> {
  Map<String, dynamic> encode(E entity);
}

class EntityField {
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

DateTime parseCreatedAt(Map<String, dynamic> json) {
  return _parseTimestamp(json: json, key: EntityField.createdAt);
}

DateTime parseUpdatedAt(Map<String, dynamic> json) {
  return _parseTimestamp(json: json, key: EntityField.updatedAt);
}

DateTime _parseTimestamp({
  @required Map<String, dynamic> json,
  @required String key,
}) {
  return json[key] == null ? null : (json[key] as Timestamp).toDate();
}

Map<String, dynamic> parseJson(
  Map<String, dynamic> json, {
  @required String key,
}) {
  final value = json[key] as Map;
  return value == null ? null : Map<String, dynamic>.from(value as Map);
}

T parse<T>(
  Map<String, dynamic> json, {
  @required String key,
  @required T Function(Map<String, dynamic>) fromJson,
}) {
  final parsedJson = parseJson(json, key: key);
  return parsedJson == null ? null : fromJson(parsedJson);
}
