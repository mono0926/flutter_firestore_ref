import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

export 'user_doc.dart';
export 'users_ref.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User, Entity, HasTimestamp {
  const factory User({
    @required int count,
    @timestampJsonKey DateTime createdAt,
    @timestampJsonKey DateTime updatedAt,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

extension UserEx on User {
  Map<String, dynamic> toJsonReplacingTimestamp() =>
      HasTimestamp.replacingTimestamp(
        json: toJson(),
        createdAt: createdAt,
      );
}
