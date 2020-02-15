import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User, Entity {
  const factory User({
    @required int count,
    @timestampJsonKey DateTime createdAt,
    @timestampJsonKey DateTime updatedAt,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

class UserDoc extends Document<User> {
  const UserDoc(
    String id,
    User entity,
  ) : super(
          id,
          entity,
        );
}

class UserRef extends DocumentRef<User, UserDoc> {
  const UserRef({
    @required DocumentReference ref,
    @required DocumentDecoder<UserDoc> decoder,
    @required EntityEncoder<User> encoder,
  }) : super(
          ref: ref,
          decoder: decoder,
          encoder: encoder,
        );
}

class UsersRef extends CollectionRef<User, UserDoc> {
  UsersRef.ref()
      : super(
          ref: Firestore.instance.collection(collection),
          decoder: (snap) => UserDoc(
            snap.documentID,
            User.fromJson(snap.data),
          ),
          encoder: (entity) => replacingTimestamp(
            json: entity.toJson(),
            createdAt: entity.createdAt,
          ),
        );

  static const collection = 'users';

  @override
  UserRef docRef([String id]) {
    return UserRef(
      ref: docRefRaw(id),
      encoder: encoder,
      decoder: decoder,
    );
  }
}
