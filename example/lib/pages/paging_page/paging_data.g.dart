// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'paging_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PagingData _$$_PagingDataFromJson(Map<String, dynamic> json) =>
    _$_PagingData(
      count: json['count'] as int? ?? 0,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$_PagingDataToJson(_$_PagingData instance) =>
    <String, dynamic>{
      'count': instance.count,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
