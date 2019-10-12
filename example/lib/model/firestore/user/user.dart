import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

export 'user_doc.dart';
export 'users_ref.dart';

class User extends Entity {
  const User({
    @required this.count,
    DateTime createdAt,
    DateTime updatedAt,
  }) : super(
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  User.fromJson(Map<String, dynamic> json)
      : this(
          count: json[UserField.count] as int,
          createdAt: parseCreatedAt(json),
          updatedAt: parseUpdatedAt(json),
        );

  final int count;

  Map<String, dynamic> toJson() => <String, dynamic>{
        UserField.count: count,
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
