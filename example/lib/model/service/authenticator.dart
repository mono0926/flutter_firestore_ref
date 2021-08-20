import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authenticator = StateNotifierProvider<Authenticator, auth.User?>(
  (ref) => Authenticator(),
);

class Authenticator extends StateNotifier<auth.User?> {
  Authenticator() : super(null) {
    _auth.userChanges().listen((user) {
      state = user;
    });
    _auth.signInAnonymously();
  }

  final _auth = auth.FirebaseAuth.instance;
}
