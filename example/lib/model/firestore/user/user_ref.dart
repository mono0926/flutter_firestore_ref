import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

import 'user.dart';
import 'user_doc.dart';

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
