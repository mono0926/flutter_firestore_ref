import 'package:firestore_ref/firestore_ref.dart' hide count;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_converter_helper/json_converter_helper.dart';

part 'user.freezed.dart';
part 'user.g.dart';

final usersRefProvider = Provider((ref) => UsersRef());

@freezed
class const User._() with _$User {
  @allJsonConvertersSerializable
  const factory({
    @Default(0) int count,
    @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
    @UnionTimestampConverter.alwaysServerTimestampConverter
    @Default(UnionTimestamp.serverTimestamp())
    UnionTimestamp updatedAt,
  }) = _User;
  factory fromJson(JsonMap json) => _$UserFromJson(json);

  User incremented() => copyWith(count: count + 1);
}

class UserField() {
  static const count = 'count';
}

// ignore: prefer_const_constructors_in_immutables
class UsersRef() extends CollectionRef<User, UserDoc, UserRef> {
  this : super(FirebaseFirestore.instance.collection('users'));

  @override
  JsonMap encode(User data) => data.toJson();

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

class const UserRef({
  required super.ref,
  required final UsersRef usersRef,
}) extends DocumentRef<User, UserDoc> {
  this
    : super(
        collectionRef: usersRef,
      );
}

// ignore: use_super_parameters
class const UserDoc(
  final UserRef userRef,
  User? entity,
) extends Document<User> {
  this : super(userRef, entity);
}
