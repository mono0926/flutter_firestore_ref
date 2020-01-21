// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    count: json['count'] as int,
    createdAt: parseTimestampValue(json['createdAt']),
    updatedAt: parseTimestampValue(json['updatedAt']),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'count': instance.count,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
