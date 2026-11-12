// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PagingData implements DiagnosticableTreeMixin {

 int get count; UnionTimestamp get createdAt;@UnionTimestampConverter.alwaysServerTimestampConverter UnionTimestamp get updatedAt;
/// Create a copy of PagingData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagingDataCopyWith<PagingData> get copyWith => _$PagingDataCopyWithImpl<PagingData>(this as PagingData, _$identity);

  /// Serializes this PagingData to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as PagingData;
  properties
    ..add(DiagnosticsProperty('type', 'PagingData'))
    ..add(DiagnosticsProperty('count', _this.count))..add(DiagnosticsProperty('createdAt', _this.createdAt))..add(DiagnosticsProperty('updatedAt', _this.updatedAt));
}

@override
bool operator ==(Object other) {
  final _this = this as PagingData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagingData&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PagingData;
  return Object.hash(runtimeType,_this.count,_this.createdAt,_this.updatedAt);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as PagingData;
  return 'PagingData(count: ${_this.count}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $PagingDataCopyWith<$Res>  {
  factory $PagingDataCopyWith(PagingData value, $Res Function(PagingData) _then) = _$PagingDataCopyWithImpl;
@useResult
$Res call({
 int count, UnionTimestamp createdAt,@UnionTimestampConverter.alwaysServerTimestampConverter UnionTimestamp updatedAt
});


$UnionTimestampCopyWith<$Res> get createdAt;$UnionTimestampCopyWith<$Res> get updatedAt;

}
/// @nodoc
class _$PagingDataCopyWithImpl<$Res>
    implements $PagingDataCopyWith<$Res> {
  _$PagingDataCopyWithImpl(this._self, this._then);

  final PagingData _self;
  final $Res Function(PagingData) _then;

/// Create a copy of PagingData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(PagingData(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as UnionTimestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as UnionTimestamp,
  ));
}
/// Create a copy of PagingData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnionTimestampCopyWith<$Res> get createdAt {
  
  return $UnionTimestampCopyWith<$Res>(_self.createdAt, (value) {
    return _then(_self.copyWith(createdAt: value));
  });
}/// Create a copy of PagingData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnionTimestampCopyWith<$Res> get updatedAt {
  
  return $UnionTimestampCopyWith<$Res>(_self.updatedAt, (value) {
    return _then(_self.copyWith(updatedAt: value));
  });
}
}


/// Adds pattern-matching-related methods to [PagingData].
extension PagingDataPatterns on PagingData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagingData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagingData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagingData value)  $default,){
final _that = this;
switch (_that) {
case _PagingData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagingData value)?  $default,){
final _that = this;
switch (_that) {
case _PagingData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  UnionTimestamp createdAt, @UnionTimestampConverter.alwaysServerTimestampConverter  UnionTimestamp updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagingData() when $default != null:
return $default(_that.count,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  UnionTimestamp createdAt, @UnionTimestampConverter.alwaysServerTimestampConverter  UnionTimestamp updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PagingData():
return $default(_that.count,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  UnionTimestamp createdAt, @UnionTimestampConverter.alwaysServerTimestampConverter  UnionTimestamp updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PagingData() when $default != null:
return $default(_that.count,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@allJsonConvertersSerializable
class _PagingData with DiagnosticableTreeMixin implements PagingData {
  const _PagingData({this.count = 0, this.createdAt = const UnionTimestamp.serverTimestamp(), @UnionTimestampConverter.alwaysServerTimestampConverter this.updatedAt = const UnionTimestamp.serverTimestamp()});
  factory _PagingData.fromJson(Map<String, dynamic> json) => _$PagingDataFromJson(json);

@override@JsonKey() final  int count;
@override@JsonKey() final  UnionTimestamp createdAt;
@override@JsonKey()@UnionTimestampConverter.alwaysServerTimestampConverter final  UnionTimestamp updatedAt;

/// Create a copy of PagingData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagingDataCopyWith<_PagingData> get copyWith => __$PagingDataCopyWithImpl<_PagingData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PagingDataToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'PagingData'))
    ..add(DiagnosticsProperty('count', count))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagingData&&(identical(other.count, count) || other.count == count)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,count,createdAt,updatedAt);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'PagingData(count: $count, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PagingDataCopyWith<$Res> implements $PagingDataCopyWith<$Res> {
  factory _$PagingDataCopyWith(_PagingData value, $Res Function(_PagingData) _then) = __$PagingDataCopyWithImpl;
@override @useResult
$Res call({
 int count, UnionTimestamp createdAt,@UnionTimestampConverter.alwaysServerTimestampConverter UnionTimestamp updatedAt
});


@override $UnionTimestampCopyWith<$Res> get createdAt;@override $UnionTimestampCopyWith<$Res> get updatedAt;

}
/// @nodoc
class __$PagingDataCopyWithImpl<$Res>
    implements _$PagingDataCopyWith<$Res> {
  __$PagingDataCopyWithImpl(this._self, this._then);

  final _PagingData _self;
  final $Res Function(_PagingData) _then;

/// Create a copy of PagingData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PagingData(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as UnionTimestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as UnionTimestamp,
  ));
}

/// Create a copy of PagingData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnionTimestampCopyWith<$Res> get createdAt {
  
  return $UnionTimestampCopyWith<$Res>(_self.createdAt, (value) {
    return _then(_self.copyWith(createdAt: value));
  });
}/// Create a copy of PagingData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnionTimestampCopyWith<$Res> get updatedAt {
  
  return $UnionTimestampCopyWith<$Res>(_self.updatedAt, (value) {
    return _then(_self.copyWith(updatedAt: value));
  });
}
}

// dart format on
