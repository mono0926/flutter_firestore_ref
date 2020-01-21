// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    count: json['count'] as int,
    createdAt: dateFromTimestampValue(json['createdAt']),
    updatedAt: dateFromTimestampValue(json['updatedAt']),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'count': instance.count,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
    };
