import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int count,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _User;
  factory User.fromJson(JsonMap json) => _$UserFromJson(json);
}

class UserField {
  static const count = 'count';
}

final usersRef = UsersRef();

class UsersRef extends CollectionRef<User, UserDoc, UserRef> {
  UsersRef() : super(FirebaseFirestore.instance.collection('users'));

  @override
  JsonMap encode(User data) => replacingTimestamp(json: data.toJson());

  @override
  UserDoc decode(DocumentSnapshot<JsonMap> snapshot, UserRef docRef) {
    return UserDoc(
      docRef,
      User.fromJson(snapshot.data()!),
    );
  }

  @override
  UserRef docRef(DocumentReference<JsonMap> ref) => UserRef(
        ref: ref,
        usersRef: this,
      );
}

class UserRef extends DocumentRef<User, UserDoc> {
  const UserRef({
    required DocumentReference<JsonMap> ref,
    required this.usersRef,
  }) : super(
          ref: ref,
          collectionRef: usersRef,
        );

  final UsersRef usersRef;
}

class UserDoc extends Document<User> {
  const UserDoc(
    this.userRef,
    User? entity,
  ) : super(userRef, entity);

  final UserRef userRef;
}
