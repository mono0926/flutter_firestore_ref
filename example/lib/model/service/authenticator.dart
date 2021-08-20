import 'package:example/model/firestore/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _authProvider = Provider((_) => FirebaseAuth.instance);

final authUserProvider = StreamProvider(
  (ref) => ref.watch(_authProvider).userChanges(),
);

final userIdProvider = Provider(
  (ref) => ref.watch(authUserProvider).whenData((user) => user?.uid),
);

final isSignedInProvider = Provider(
  (ref) => ref.watch(userIdProvider).whenData((id) => id != null),
);

final signInAnonymouslyProvider = FutureProvider(
  (ref) => ref.watch(_authProvider).signInAnonymously(),
);
final myUserRefProvider = Provider(
  (ref) => ref.watch(userIdProvider).whenData(
        (userId) => userId == null ? null : ref.watch(userRefs(userId)),
      ),
);

final myUserDocProvider = Provider(
  (ref) {
    return ref.watch(myUserRefProvider).whenData(
      (userRef) {
        return userRef == null
            ? null
            : ref.watch(userDocs(userRef.id)).maybeWhen(
                  data: (doc) => doc,
                  orElse: () => UserDoc(userRef, null),
                );
      },
    );
  },
);

final myCountProvider = Provider(
  (ref) => ref.watch(myUserDocProvider).whenData((doc) => doc?.entity?.count),
);
