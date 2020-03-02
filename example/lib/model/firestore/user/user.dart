import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @required int count,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

final CollectionRef<User, Document<User>> usersRef = CollectionRef(
  Firestore.instance.collection('users'),
  decoder: (snapshot) => Document(
    snapshot.documentID,
    User.fromJson(snapshot.data),
  ),
  encoder: (user) => replacingTimestamp(
    json: user.toJson(),
    createdAt: user.createdAt,
  ),
);

//Or this:
//class UsersRef extends CollectionRef<User, Document<User>> {
//  UsersRef()
//      : super(
//          Firestore.instance.collection('users'),
//          decoder: (snapshot) => Document<User>(
//            snapshot.documentID,
//            User.fromJson(snapshot.data),
//          ),
//          encoder: (user) => replacingTimestamp(
//            json: user.toJson(),
//            createdAt: user.createdAt,
//          ),
//        );
//}
