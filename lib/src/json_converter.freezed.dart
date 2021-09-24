// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'json_converter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FirTimestampTearOff {
  const _$FirTimestampTearOff();

  FirDateTime dateTime(DateTime date) {
    return FirDateTime(
      date,
    );
  }

  FirServerTimestamp serverTimestamp() {
    return const FirServerTimestamp();
  }
}

/// @nodoc
const $FirTimestamp = _$FirTimestampTearOff();

/// @nodoc
mixin _$FirTimestamp {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime date) dateTime,
    required TResult Function() serverTimestamp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime date)? dateTime,
    TResult Function()? serverTimestamp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateTime,
    TResult Function()? serverTimestamp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FirDateTime value) dateTime,
    required TResult Function(FirServerTimestamp value) serverTimestamp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FirDateTime value)? dateTime,
    TResult Function(FirServerTimestamp value)? serverTimestamp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FirDateTime value)? dateTime,
    TResult Function(FirServerTimestamp value)? serverTimestamp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirTimestampCopyWith<$Res> {
  factory $FirTimestampCopyWith(
          FirTimestamp value, $Res Function(FirTimestamp) then) =
      _$FirTimestampCopyWithImpl<$Res>;
}

/// @nodoc
class _$FirTimestampCopyWithImpl<$Res> implements $FirTimestampCopyWith<$Res> {
  _$FirTimestampCopyWithImpl(this._value, this._then);

  final FirTimestamp _value;
  // ignore: unused_field
  final $Res Function(FirTimestamp) _then;
}

/// @nodoc
abstract class $FirDateTimeCopyWith<$Res> {
  factory $FirDateTimeCopyWith(
          FirDateTime value, $Res Function(FirDateTime) then) =
      _$FirDateTimeCopyWithImpl<$Res>;
  $Res call({DateTime date});
}

/// @nodoc
class _$FirDateTimeCopyWithImpl<$Res> extends _$FirTimestampCopyWithImpl<$Res>
    implements $FirDateTimeCopyWith<$Res> {
  _$FirDateTimeCopyWithImpl(
      FirDateTime _value, $Res Function(FirDateTime) _then)
      : super(_value, (v) => _then(v as FirDateTime));

  @override
  FirDateTime get _value => super._value as FirDateTime;

  @override
  $Res call({
    Object? date = freezed,
  }) {
    return _then(FirDateTime(
      date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$FirDateTime with DiagnosticableTreeMixin implements FirDateTime {
  const _$FirDateTime(this.date);

  @override
  final DateTime date;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirTimestamp.dateTime(date: $date)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirTimestamp.dateTime'))
      ..add(DiagnosticsProperty('date', date));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FirDateTime &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(date);

  @JsonKey(ignore: true)
  @override
  $FirDateTimeCopyWith<FirDateTime> get copyWith =>
      _$FirDateTimeCopyWithImpl<FirDateTime>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime date) dateTime,
    required TResult Function() serverTimestamp,
  }) {
    return dateTime(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime date)? dateTime,
    TResult Function()? serverTimestamp,
  }) {
    return dateTime?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateTime,
    TResult Function()? serverTimestamp,
    required TResult orElse(),
  }) {
    if (dateTime != null) {
      return dateTime(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FirDateTime value) dateTime,
    required TResult Function(FirServerTimestamp value) serverTimestamp,
  }) {
    return dateTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FirDateTime value)? dateTime,
    TResult Function(FirServerTimestamp value)? serverTimestamp,
  }) {
    return dateTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FirDateTime value)? dateTime,
    TResult Function(FirServerTimestamp value)? serverTimestamp,
    required TResult orElse(),
  }) {
    if (dateTime != null) {
      return dateTime(this);
    }
    return orElse();
  }
}

abstract class FirDateTime implements FirTimestamp {
  const factory FirDateTime(DateTime date) = _$FirDateTime;

  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirDateTimeCopyWith<FirDateTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirServerTimestampCopyWith<$Res> {
  factory $FirServerTimestampCopyWith(
          FirServerTimestamp value, $Res Function(FirServerTimestamp) then) =
      _$FirServerTimestampCopyWithImpl<$Res>;
}

/// @nodoc
class _$FirServerTimestampCopyWithImpl<$Res>
    extends _$FirTimestampCopyWithImpl<$Res>
    implements $FirServerTimestampCopyWith<$Res> {
  _$FirServerTimestampCopyWithImpl(
      FirServerTimestamp _value, $Res Function(FirServerTimestamp) _then)
      : super(_value, (v) => _then(v as FirServerTimestamp));

  @override
  FirServerTimestamp get _value => super._value as FirServerTimestamp;
}

/// @nodoc

class _$FirServerTimestamp
    with DiagnosticableTreeMixin
    implements FirServerTimestamp {
  const _$FirServerTimestamp();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirTimestamp.serverTimestamp()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirTimestamp.serverTimestamp'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is FirServerTimestamp);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime date) dateTime,
    required TResult Function() serverTimestamp,
  }) {
    return serverTimestamp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DateTime date)? dateTime,
    TResult Function()? serverTimestamp,
  }) {
    return serverTimestamp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime date)? dateTime,
    TResult Function()? serverTimestamp,
    required TResult orElse(),
  }) {
    if (serverTimestamp != null) {
      return serverTimestamp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FirDateTime value) dateTime,
    required TResult Function(FirServerTimestamp value) serverTimestamp,
  }) {
    return serverTimestamp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FirDateTime value)? dateTime,
    TResult Function(FirServerTimestamp value)? serverTimestamp,
  }) {
    return serverTimestamp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FirDateTime value)? dateTime,
    TResult Function(FirServerTimestamp value)? serverTimestamp,
    required TResult orElse(),
  }) {
    if (serverTimestamp != null) {
      return serverTimestamp(this);
    }
    return orElse();
  }
}

abstract class FirServerTimestamp implements FirTimestamp {
  const factory FirServerTimestamp() = _$FirServerTimestamp;
}
