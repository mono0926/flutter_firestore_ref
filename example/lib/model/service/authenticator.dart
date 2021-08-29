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
  (ref) {
    final userId = ref.watch(userIdProvider);
    final usersRef = ref.watch(usersRefProvider);
    return userId.whenData(usersRef.docRefWithId);
  },
);

final _myUserDocProvider = StreamProvider.autoDispose(
  (ref) =>
      ref.watch(myUserRefProvider).data?.value.document() ?? Stream.value(null),
);

final myUserDocProvider = Provider.autoDispose(
  (ref) {
    final doc = ref.watch(_myUserDocProvider).data?.value;
    return ref.watch(myUserRefProvider).whenData((userRef) =>
        doc ??
        UserDoc(
          userRef,
          const User(),
        ));
  },
);

final myCountProvider = Provider.autoDispose(
  (ref) => ref.watch(myUserDocProvider).whenData((doc) => doc.entity?.count),
);
