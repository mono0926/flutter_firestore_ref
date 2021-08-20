import 'package:example/model/firestore/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _authProvider = Provider((_) => auth.FirebaseAuth.instance);

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
        (userId) => userId == null ? null : ref.watch(userRefProviders(userId)),
      ),
);

final myUserDocProvider = Provider(
  (ref) {
    const emptyUser = User();
    return ref.watch(myUserRefProvider).whenData(
      (userRef) {
        return userRef == null
            ? null
            : ref.watch(userDocProviders(userRef.id)).maybeWhen(
                  data: (doc) => doc ?? UserDoc(userRef, emptyUser),
                  orElse: () => UserDoc(userRef, emptyUser),
                );
      },
    );
  },
);

final myCountProvider = Provider(
  (ref) => ref.watch(myUserDocProvider).whenData((doc) => doc?.entity?.count),
);
