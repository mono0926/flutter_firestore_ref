// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'paging_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PagingData _$PagingDataFromJson(Map<String, dynamic> json) {
  return _PagingData.fromJson(json);
}

/// @nodoc
class _$PagingDataTearOff {
  const _$PagingDataTearOff();

  _PagingData call(
      {int count = 0,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt}) {
    return _PagingData(
      count: count,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  PagingData fromJson(Map<String, Object> json) {
    return PagingData.fromJson(json);
  }
}

/// @nodoc
const $PagingData = _$PagingDataTearOff();

/// @nodoc
mixin _$PagingData {
  int get count => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
  $Res call(
      {int count,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
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
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$PagingDataCopyWith<$Res> implements $PagingDataCopyWith<$Res> {
  factory _$PagingDataCopyWith(
          _PagingData value, $Res Function(_PagingData) then) =
      __$PagingDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {int count,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$PagingDataCopyWithImpl<$Res> extends _$PagingDataCopyWithImpl<$Res>
    implements _$PagingDataCopyWith<$Res> {
  __$PagingDataCopyWithImpl(
      _PagingData _value, $Res Function(_PagingData) _then)
      : super(_value, (v) => _then(v as _PagingData));

  @override
  _PagingData get _value => super._value as _PagingData;

  @override
  $Res call({
    Object? count = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_PagingData(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PagingData with DiagnosticableTreeMixin implements _PagingData {
  const _$_PagingData(
      {this.count = 0,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt});

  factory _$_PagingData.fromJson(Map<String, dynamic> json) =>
      _$$_PagingDataFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final int count;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

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
        (other is _PagingData &&
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

  @JsonKey(ignore: true)
  @override
  _$PagingDataCopyWith<_PagingData> get copyWith =>
      __$PagingDataCopyWithImpl<_PagingData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PagingDataToJson(this);
  }
}

abstract class _PagingData implements PagingData {
  const factory _PagingData(
      {int count,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt}) = _$_PagingData;

  factory _PagingData.fromJson(Map<String, dynamic> json) =
      _$_PagingData.fromJson;

  @override
  int get count => throw _privateConstructorUsedError;
  @override
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PagingDataCopyWith<_PagingData> get copyWith =>
      throw _privateConstructorUsedError;
}
