import 'package:firestore_ref/firestore_ref.dart';

import 'user.dart';
import 'user_doc.dart';
import 'user_ref.dart';

export 'user_ref.dart';

class UsersRef extends CollectionRef<User, UserDoc> {
  UsersRef.ref()
      : super(
          ref: Firestore.instance.collection(collection),
          decoder: _UserDocDecoder(),
          encoder: _UserEncoder(),
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

class _UserDocDecoder extends DocumentDecoder<UserDoc> {
  @override
  UserDoc decode(DocumentSnapshot snapshot) {
    return UserDoc(
      snapshot.documentID,
      User.fromJson(snapshot.data),
    );
  }
}

class _UserEncoder extends EntityEncoder<User> {
  @override
  Map<String, dynamic> encode(User entity) => entity.toJsonReplacingTimestamp();
}
