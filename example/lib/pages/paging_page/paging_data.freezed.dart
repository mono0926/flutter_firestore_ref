// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'paging_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
PagingData _$PagingDataFromJson(Map<String, dynamic> json) {
  return _PagingData.fromJson(json);
}

class _$PagingDataTearOff {
  const _$PagingDataTearOff();

// ignore: unused_element
  _PagingData call(
      {int count = 0,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt}) {
    return _PagingData(
      count: count,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

// ignore: unused_element
const $PagingData = _$PagingDataTearOff();

mixin _$PagingData {
  int get count;
  @TimestampConverter()
  DateTime get createdAt;
  @TimestampConverter()
  DateTime get updatedAt;

  Map<String, dynamic> toJson();
  $PagingDataCopyWith<PagingData> get copyWith;
}

abstract class $PagingDataCopyWith<$Res> {
  factory $PagingDataCopyWith(
          PagingData value, $Res Function(PagingData) then) =
      _$PagingDataCopyWithImpl<$Res>;
  $Res call(
      {int count,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}

class _$PagingDataCopyWithImpl<$Res> implements $PagingDataCopyWith<$Res> {
  _$PagingDataCopyWithImpl(this._value, this._then);

  final PagingData _value;
  // ignore: unused_field
  final $Res Function(PagingData) _then;

  @override
  $Res call({
    Object count = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed ? _value.count : count as int,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
    ));
  }
}

abstract class _$PagingDataCopyWith<$Res> implements $PagingDataCopyWith<$Res> {
  factory _$PagingDataCopyWith(
          _PagingData value, $Res Function(_PagingData) then) =
      __$PagingDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {int count,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}

class __$PagingDataCopyWithImpl<$Res> extends _$PagingDataCopyWithImpl<$Res>
    implements _$PagingDataCopyWith<$Res> {
  __$PagingDataCopyWithImpl(
      _PagingData _value, $Res Function(_PagingData) _then)
      : super(_value, (v) => _then(v as _PagingData));

  @override
  _PagingData get _value => super._value as _PagingData;

  @override
  $Res call({
    Object count = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_PagingData(
      count: count == freezed ? _value.count : count as int,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
    ));
  }
}

@JsonSerializable()
class _$_PagingData with DiagnosticableTreeMixin implements _PagingData {
  const _$_PagingData(
      {this.count = 0,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : assert(count != null);

  factory _$_PagingData.fromJson(Map<String, dynamic> json) =>
      _$_$_PagingDataFromJson(json);

  @JsonKey(defaultValue: 0)
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

  @override
  _$PagingDataCopyWith<_PagingData> get copyWith =>
      __$PagingDataCopyWithImpl<_PagingData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PagingDataToJson(this);
  }
}

abstract class _PagingData implements PagingData {
  const factory _PagingData(
      {int count,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt}) = _$_PagingData;

  factory _PagingData.fromJson(Map<String, dynamic> json) =
      _$_PagingData.fromJson;

  @override
  int get count;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;
  @override
  _$PagingDataCopyWith<_PagingData> get copyWith;
}
