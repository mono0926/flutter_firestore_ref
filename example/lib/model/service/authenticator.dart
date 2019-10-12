import 'package:fb_auth/fb_auth.dart';
import 'package:flutter/foundation.dart';

class Authenticator extends ChangeNotifier {
  Authenticator() {
    _auth.state.listen((state) {
      _state = state;
      notifyListeners();
    });
  }

  final _auth = AuthBloc(app: null);
  AuthState _state;

  AuthState get state => _state;
  AuthUser get user =>
      state is LoggedInState ? (state as LoggedInState).user : null;

  void signInAnonymously() {
    _auth.dispatch(LoginGuest());
  }
}
