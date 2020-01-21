import 'package:meta/meta.dart';

mixin Entity {}

@immutable
// ignore: one_member_abstracts
abstract class EntityEncoder<E extends Entity> {
  Map<String, dynamic> encode(E entity);
}

Map<String, dynamic> parseJson(
  Map<String, dynamic> json, {
  @required String key,
}) {
  final value = json[key] as Map;
  return value == null ? null : Map<String, dynamic>.from(value);
}

T parse<T>(
  Map<String, dynamic> json, {
  @required String key,
  @required T Function(Map<String, dynamic>) fromJson,
}) {
  final parsedJson = parseJson(json, key: key);
  return parsedJson == null ? null : fromJson(parsedJson);
}
