import 'package:firestore_ref/firestore_ref.dart';

import 'user.dart';

class UserDoc extends Document<User> {
  const UserDoc(
    String id,
    User entity,
  ) : super(
          id,
          entity,
        );
}
