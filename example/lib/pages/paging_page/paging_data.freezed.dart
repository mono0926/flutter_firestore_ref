// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PagingData _$PagingDataFromJson(Map<String, dynamic> json) {
  return _PagingData.fromJson(json);
}

/// @nodoc
mixin _$PagingData {
  int get count => throw _privateConstructorUsedError;
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;
  @UnionTimestampConverter.alwaysServerTimestampConverter
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
      _$PagingDataCopyWithImpl<$Res, PagingData>;
  @useResult
  $Res call(
      {int count,
      UnionTimestamp createdAt,
      @UnionTimestampConverter.alwaysServerTimestampConverter
      UnionTimestamp updatedAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class _$PagingDataCopyWithImpl<$Res, $Val extends PagingData>
    implements $PagingDataCopyWith<$Res> {
  _$PagingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get updatedAt {
    return $UnionTimestampCopyWith<$Res>(_value.updatedAt, (value) {
      return _then(_value.copyWith(updatedAt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PagingDataImplCopyWith<$Res>
    implements $PagingDataCopyWith<$Res> {
  factory _$$PagingDataImplCopyWith(
          _$PagingDataImpl value, $Res Function(_$PagingDataImpl) then) =
      __$$PagingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int count,
      UnionTimestamp createdAt,
      @UnionTimestampConverter.alwaysServerTimestampConverter
      UnionTimestamp updatedAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
  @override
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class __$$PagingDataImplCopyWithImpl<$Res>
    extends _$PagingDataCopyWithImpl<$Res, _$PagingDataImpl>
    implements _$$PagingDataImplCopyWith<$Res> {
  __$$PagingDataImplCopyWithImpl(
      _$PagingDataImpl _value, $Res Function(_$PagingDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$PagingDataImpl(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc

@allJsonConvertersSerializable
class _$PagingDataImpl with DiagnosticableTreeMixin implements _PagingData {
  const _$PagingDataImpl(
      {this.count = 0,
      this.createdAt = const UnionTimestamp.serverTimestamp(),
      @UnionTimestampConverter.alwaysServerTimestampConverter
      this.updatedAt = const UnionTimestamp.serverTimestamp()});

  factory _$PagingDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PagingDataImplFromJson(json);

  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final UnionTimestamp createdAt;
  @override
  @JsonKey()
  @UnionTimestampConverter.alwaysServerTimestampConverter
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingDataImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, count, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingDataImplCopyWith<_$PagingDataImpl> get copyWith =>
      __$$PagingDataImplCopyWithImpl<_$PagingDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PagingDataImplToJson(
      this,
    );
  }
}

abstract class _PagingData implements PagingData {
  const factory _PagingData(
      {final int count,
      final UnionTimestamp createdAt,
      @UnionTimestampConverter.alwaysServerTimestampConverter
      final UnionTimestamp updatedAt}) = _$PagingDataImpl;

  factory _PagingData.fromJson(Map<String, dynamic> json) =
      _$PagingDataImpl.fromJson;

  @override
  int get count;
  @override
  UnionTimestamp get createdAt;
  @override
  @UnionTimestampConverter.alwaysServerTimestampConverter
  UnionTimestamp get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PagingDataImplCopyWith<_$PagingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
