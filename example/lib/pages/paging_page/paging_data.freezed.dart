// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'paging_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PagingData _$PagingDataFromJson(Map<String, dynamic> json) {
  return _PagingData.fromJson(json);
}

/// @nodoc
mixin _$PagingData {
  int get count => throw _privateConstructorUsedError;
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;
  UnionTimestamp get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PagingDataCopyWith<PagingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingDataCopyWith<$Res> {
  factory $PagingDataCopyWith(
          PagingData value, $Res Function(PagingData) then) =
      _$PagingDataCopyWithImpl<$Res>;
  $Res call({int count, UnionTimestamp createdAt, UnionTimestamp updatedAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class _$PagingDataCopyWithImpl<$Res> implements $PagingDataCopyWith<$Res> {
  _$PagingDataCopyWithImpl(this._value, this._then);

  final PagingData _value;
  // ignore: unused_field
  final $Res Function(PagingData) _then;

  @override
  $Res call({
    Object? count = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }

  @override
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value));
    });
  }

  @override
  $UnionTimestampCopyWith<$Res> get updatedAt {
    return $UnionTimestampCopyWith<$Res>(_value.updatedAt, (value) {
      return _then(_value.copyWith(updatedAt: value));
    });
  }
}

/// @nodoc
abstract class _$$_PagingDataCopyWith<$Res>
    implements $PagingDataCopyWith<$Res> {
  factory _$$_PagingDataCopyWith(
          _$_PagingData value, $Res Function(_$_PagingData) then) =
      __$$_PagingDataCopyWithImpl<$Res>;
  @override
  $Res call({int count, UnionTimestamp createdAt, UnionTimestamp updatedAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
  @override
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class __$$_PagingDataCopyWithImpl<$Res> extends _$PagingDataCopyWithImpl<$Res>
    implements _$$_PagingDataCopyWith<$Res> {
  __$$_PagingDataCopyWithImpl(
      _$_PagingData _value, $Res Function(_$_PagingData) _then)
      : super(_value, (v) => _then(v as _$_PagingData));

  @override
  _$_PagingData get _value => super._value as _$_PagingData;

  @override
  $Res call({
    Object? count = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_PagingData(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc

@allJsonConvertersSerializable
class _$_PagingData with DiagnosticableTreeMixin implements _PagingData {
  const _$_PagingData(
      {this.count = 0,
      this.createdAt = const UnionTimestamp.serverTimestamp(),
      this.updatedAt = const UnionTimestamp.serverTimestamp()});

  factory _$_PagingData.fromJson(Map<String, dynamic> json) =>
      _$$_PagingDataFromJson(json);

  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final UnionTimestamp createdAt;
  @override
  @JsonKey()
  final UnionTimestamp updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PagingData(count: $count, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PagingData'))
      ..add(DiagnosticsProperty('count', count))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PagingData &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_PagingDataCopyWith<_$_PagingData> get copyWith =>
      __$$_PagingDataCopyWithImpl<_$_PagingData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PagingDataToJson(this);
  }
}

abstract class _PagingData implements PagingData {
  const factory _PagingData(
      {final int count,
      final UnionTimestamp createdAt,
      final UnionTimestamp updatedAt}) = _$_PagingData;

  factory _PagingData.fromJson(Map<String, dynamic> json) =
      _$_PagingData.fromJson;

  @override
  int get count;
  @override
  UnionTimestamp get createdAt;
  @override
  UnionTimestamp get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_PagingDataCopyWith<_$_PagingData> get copyWith =>
      throw _privateConstructorUsedError;
}
