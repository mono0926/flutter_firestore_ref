// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'paging_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PagingData _$$_PagingDataFromJson(Map json) => _$_PagingData(
      count: json['count'] as int? ?? 0,
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : const UnionTimestampConverter()
              .fromJson(json['createdAt'] as Object),
      updatedAt: json['updatedAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : UnionTimestampConverter.alwaysServerTimestampConverter
              .fromJson(json['updatedAt'] as Object),
    );

Map<String, dynamic> _$$_PagingDataToJson(_$_PagingData instance) =>
    <String, dynamic>{
      'count': instance.count,
      'createdAt': const UnionTimestampConverter().toJson(instance.createdAt),
      'updatedAt': UnionTimestampConverter.alwaysServerTimestampConverter
          .toJson(instance.updatedAt),
    };
