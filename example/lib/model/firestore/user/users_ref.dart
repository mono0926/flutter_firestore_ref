import 'package:firestore_ref/firestore_ref.dart';

import 'user.dart';
import 'user_doc.dart';
import 'user_ref.dart';

export 'user_ref.dart';

class UsersRef extends CollectionRef<User, UserDoc> {
  UsersRef.ref()
      : super(
          ref: Firestore.instance.collection(collection),
          decoder: (snap) => UserDoc(
            snap.documentID,
            User.fromJson(snap.data),
          ),
          encoder: (entity) => entity.toJsonReplacingTimestamp(),
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
