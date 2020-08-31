import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

class Authenticator extends ChangeNotifier {
  Authenticator() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  final _auth = auth.FirebaseAuth.instance;
  auth.User _user;

  auth.User get user => (!kIsWeb && Platform.isMacOS == true) ? null : _user;

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }
}
