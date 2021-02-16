import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final authenticator = ChangeNotifierProvider((ref) => Authenticator());

class Authenticator extends ChangeNotifier {
  Authenticator() {
    signInAnonymously();
    _auth.userChanges().pipe(_userStream);
    _userStream.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  final _auth = auth.FirebaseAuth.instance;
  final _userStream = BehaviorSubject<auth.User?>();
  auth.User? _user;

  auth.User? get user => (!kIsWeb && Platform.isMacOS == true) ? null : _user;
  ValueStream<auth.User?> get userStream => _userStream;

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }
}
