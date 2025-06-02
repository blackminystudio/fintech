import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus {
  unauthenticated,
  authenticated,
  disabled,
}

final appRouterNotifier = Provider<AppRouterNotifier>(
  (ref) => AppRouterNotifier(),
);

class AppRouterNotifier extends ChangeNotifier {
  AuthStatus _status = AuthStatus.unauthenticated;
  AuthStatus get status => _status;

  void setAuthenticated() {
    _status = AuthStatus.authenticated;
    notifyListeners();
  }

  void setDisabled() {
    _status = AuthStatus.disabled;
    notifyListeners();
  }

  void setUnauthenticated() {
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
