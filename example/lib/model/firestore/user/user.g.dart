// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unused_field, unused_element

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map json) => _$UserImpl(
      count: (json['count'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : const UnionTimestampConverter()
              .fromJson(json['createdAt'] as Object),
      updatedAt: json['updatedAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : UnionTimestampConverter.alwaysServerTimestampConverter
              .fromJson(json['updatedAt'] as Object),
    );

abstract final class _$$UserImplJsonKeys {
  static const String count = 'count';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
}

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'createdAt': const UnionTimestampConverter().toJson(instance.createdAt),
      'updatedAt': UnionTimestampConverter.alwaysServerTimestampConverter
          .toJson(instance.updatedAt),
    };
