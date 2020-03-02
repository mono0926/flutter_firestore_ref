// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

mixin _$User {
  int get count;
  @TimestampConverter()
  DateTime get createdAt;
  @TimestampConverter()
  DateTime get updatedAt;

  User copyWith(
      {int count,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});

  Map<String, dynamic> toJson();
}

class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {@required int count,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt}) {
    return _User(
      count: count,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

const $User = _$UserTearOff();

@JsonSerializable()
class _$_User with DiagnosticableTreeMixin implements _User {
  const _$_User(
      {@required this.count,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : assert(count != null);

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final int count;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(count: $count, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('count', count))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @override
  _$_User copyWith({
    Object count = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _$_User(
      count: count == freezed ? this.count : count as int,
      createdAt: createdAt == freezed ? this.createdAt : createdAt as DateTime,
      updatedAt: updatedAt == freezed ? this.updatedAt : updatedAt as DateTime,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User implements User {
  const factory _User(
      {@required int count,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  int get count;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  @override
  _User copyWith(
      {int count,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}
