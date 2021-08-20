import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final authenticator =
    StateNotifierProvider<Authenticator, auth.User?>((ref) => Authenticator());

class Authenticator extends StateNotifier<auth.User?> {
  Authenticator() : super(null) {
    signInAnonymously();
    _auth.userChanges().pipe(_userStream);
    _userStream.listen((user) {
      _user = user;
    });
  }

  final _auth = auth.FirebaseAuth.instance;
  final _userStream = BehaviorSubject<auth.User?>();
  auth.User? _user;

  auth.User? get user => _user;
  ValueStream<auth.User?> get userStream => _userStream;

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }
}
