import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'user.freezed.dart';
part 'user.g.dart';

final usersRefProvider = Provider((ref) => UsersRef());

@freezed
class User with _$User {
  const factory User({
    @Default(0) int count,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _User;
  factory User.fromJson(JsonMap json) => _$UserFromJson(json);

  const User._();

  User incremented() => copyWith(count: count + 1);
}

class UserField {
  static const count = 'count';
}

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
