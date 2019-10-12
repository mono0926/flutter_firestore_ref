import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import 'user.dart';
import 'user_doc.dart';
import 'user_ref.dart';

export 'user_ref.dart';

class UsersRef extends CollectionRef<User, UserDoc> {
  const UsersRef._({
    @required CollectionReference ref,
    @required DocumentDecoder<UserDoc> decoder,
    @required EntityEncoder<User> encoder,
  }) : super(
          ref: ref,
          decoder: decoder,
          encoder: encoder,
        );

  factory UsersRef.ref() {
    return UsersRef._(
      ref: Firestore.instance.collection(collection),
      decoder: _UserDocDecoder(),
      encoder: _UserEncoder(),
    );
  }

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

class _UserDocDecoder extends DocumentDecoder<UserDoc> {
  @override
  UserDoc decode(DocumentSnapshot snapshot) {
    final data = snapshot.data;
    return UserDoc(
      snapshot.documentID,
      User.fromJson(data),
    );
  }
}

class _UserEncoder extends EntityEncoder<User> {
  @override
  Map<String, dynamic> encode(User entity) {
    return entity.toJson();
  }
}
