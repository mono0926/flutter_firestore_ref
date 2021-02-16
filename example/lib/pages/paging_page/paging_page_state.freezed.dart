// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'paging_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PagingPageStateTearOff {
  const _$PagingPageStateTearOff();

  _PagingPageState call(
      {List<PagingDataDoc> docs = const <PagingDataDoc>[],
      bool hasMore = true}) {
    return _PagingPageState(
      docs: docs,
      hasMore: hasMore,
    );
  }
}

/// @nodoc
const $PagingPageState = _$PagingPageStateTearOff();

/// @nodoc
mixin _$PagingPageState {
  List<PagingDataDoc> get docs;
  bool get hasMore;

  @JsonKey(ignore: true)
  $PagingPageStateCopyWith<PagingPageState> get copyWith;
}

/// @nodoc
abstract class $PagingPageStateCopyWith<$Res> {
  factory $PagingPageStateCopyWith(
          PagingPageState value, $Res Function(PagingPageState) then) =
      _$PagingPageStateCopyWithImpl<$Res>;
  $Res call({List<PagingDataDoc> docs, bool hasMore});
}

/// @nodoc
class _$PagingPageStateCopyWithImpl<$Res>
    implements $PagingPageStateCopyWith<$Res> {
  _$PagingPageStateCopyWithImpl(this._value, this._then);

  final PagingPageState _value;
  // ignore: unused_field
  final $Res Function(PagingPageState) _then;

  @override
  $Res call({
    Object? docs = freezed,
    Object? hasMore = freezed,
  }) {
    return _then(_value.copyWith(
      docs: docs == freezed ? _value.docs : docs as List<PagingDataDoc>,
      hasMore: hasMore == freezed ? _value.hasMore : hasMore as bool,
    ));
  }
}

/// @nodoc
abstract class _$PagingPageStateCopyWith<$Res>
    implements $PagingPageStateCopyWith<$Res> {
  factory _$PagingPageStateCopyWith(
          _PagingPageState value, $Res Function(_PagingPageState) then) =
      __$PagingPageStateCopyWithImpl<$Res>;
  @override
  $Res call({List<PagingDataDoc> docs, bool hasMore});
}

/// @nodoc
class __$PagingPageStateCopyWithImpl<$Res>
    extends _$PagingPageStateCopyWithImpl<$Res>
    implements _$PagingPageStateCopyWith<$Res> {
  __$PagingPageStateCopyWithImpl(
      _PagingPageState _value, $Res Function(_PagingPageState) _then)
      : super(_value, (v) => _then(v as _PagingPageState));

  @override
  _PagingPageState get _value => super._value as _PagingPageState;

  @override
  $Res call({
    Object? docs = freezed,
    Object? hasMore = freezed,
  }) {
    return _then(_PagingPageState(
      docs: docs == freezed ? _value.docs : docs as List<PagingDataDoc>,
      hasMore: hasMore == freezed ? _value.hasMore : hasMore as bool,
    ));
  }
}

/// @nodoc
class _$_PagingPageState extends _PagingPageState with DiagnosticableTreeMixin {
  _$_PagingPageState({this.docs = const <PagingDataDoc>[], this.hasMore = true})
      : super._();

  @JsonKey(defaultValue: const <PagingDataDoc>[])
  @override
  final List<PagingDataDoc> docs;
  @JsonKey(defaultValue: true)
  @override
  final bool hasMore;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PagingPageState(docs: $docs, hasMore: $hasMore)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PagingPageState'))
      ..add(DiagnosticsProperty('docs', docs))
      ..add(DiagnosticsProperty('hasMore', hasMore));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PagingPageState &&
            (identical(other.docs, docs) ||
                const DeepCollectionEquality().equals(other.docs, docs)) &&
            (identical(other.hasMore, hasMore) ||
                const DeepCollectionEquality().equals(other.hasMore, hasMore)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(docs) ^
      const DeepCollectionEquality().hash(hasMore);

  @JsonKey(ignore: true)
  @override
  _$PagingPageStateCopyWith<_PagingPageState> get copyWith =>
      __$PagingPageStateCopyWithImpl<_PagingPageState>(this, _$identity);
}

abstract class _PagingPageState extends PagingPageState {
  _PagingPageState._() : super._();
  factory _PagingPageState({List<PagingDataDoc> docs, bool hasMore}) =
      _$_PagingPageState;

  @override
  List<PagingDataDoc> get docs;
  @override
  bool get hasMore;
  @override
  @JsonKey(ignore: true)
  _$PagingPageStateCopyWith<_PagingPageState> get copyWith;
}
