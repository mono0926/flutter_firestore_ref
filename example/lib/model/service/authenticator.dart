import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authenticator extends ChangeNotifier {
  Authenticator() {
    _auth.onAuthStateChanged.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  FirebaseUser get user => (!kIsWeb && Platform.isMacOS == true) ? null : _user;

  void signInAnonymously() {
    _auth.signInAnonymously();
  }
}
