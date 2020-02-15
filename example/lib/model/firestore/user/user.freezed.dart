// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

mixin _$User {
  int get count;
  @timestampJsonKey
  DateTime get createdAt;
  @timestampJsonKey
  DateTime get updatedAt;

  User copyWith(
      {int count,
      @timestampJsonKey DateTime createdAt,
      @timestampJsonKey DateTime updatedAt});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_User with DiagnosticableTreeMixin implements _User {
  const _$_User(
      {@required this.count,
      @timestampJsonKey this.createdAt,
      @timestampJsonKey this.updatedAt})
      : assert(count != null);

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final int count;
  @override
  @timestampJsonKey
  final DateTime createdAt;
  @override
  @timestampJsonKey
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
      count.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  _$_User copyWith({
    Object count = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    assert(count != null);
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
      @timestampJsonKey DateTime createdAt,
      @timestampJsonKey DateTime updatedAt}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  int get count;
  @override
  @timestampJsonKey
  DateTime get createdAt;
  @override
  @timestampJsonKey
  DateTime get updatedAt;

  @override
  _User copyWith(
      {int count,
      @timestampJsonKey DateTime createdAt,
      @timestampJsonKey DateTime updatedAt});
}
