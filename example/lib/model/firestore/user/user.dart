import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

export 'user_doc.dart';
export 'users_ref.dart';

part 'user.g.dart';

@JsonSerializable()
class User with Entity, HasTimestamp {
  User({
    @required this.count,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int count;
  @override
  @JsonKey(fromJson: dateFromTimestampValue)
  final DateTime createdAt;
  @override
  @JsonKey(fromJson: dateFromTimestampValue)
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
        ..._$UserToJson(this)..remove(TimestampField.createdAt),
        ...timestampJson,
      };

  User copyWith({
    int count,
  }) {
    return User(
      count: count ?? this.count,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          super == other &&
          count == other.count;

  @override
  int get hashCode => count.hashCode ^ super.hashCode;
}

class UserField {
  static const count = 'count';
}
