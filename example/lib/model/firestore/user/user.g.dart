// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      count: json['count'] as int? ?? 0,
      createdAt: const FirTimestampConverter().fromJson(json['createdAt']),
      updatedAt: const FirTimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'count': instance.count,
      'createdAt': const FirTimestampConverter().toJson(instance.createdAt),
      'updatedAt': const FirTimestampConverter().toJson(instance.updatedAt),
    };
