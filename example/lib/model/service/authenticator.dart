import 'dart:io';

import 'package:fb_auth/fb_auth.dart';
import 'package:flutter/foundation.dart';

class Authenticator extends ChangeNotifier {
  Authenticator() {
    _auth.listen((state) {
      _state = state;
      notifyListeners();
    });
  }

  final _auth = AuthBloc(app: null);
  AuthState _state;

  AuthState get state => _state;
  AuthUser get user {
    // TODO(mono): 認証部分が動かないので暫定処置(Webだとnullなのでtrue比較)
    if (Platform.isMacOS == true) {
      return AuthUser(uid: 'macOS');
    }
    return state is LoggedInState ? (state as LoggedInState).user : null;
  }

  void signInAnonymously() {
    _auth.add(LoginGuest());
  }
}
