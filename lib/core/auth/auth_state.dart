import 'package:flutter/foundation.dart';

enum AuthStatus { guest, authenticated }

enum AuthRole { user, admin }

class AuthState extends ChangeNotifier {
  AuthStatus _status = AuthStatus.guest;
  Set<AuthRole> _roles = const <AuthRole>{};
  bool _sessionExpired = false;

  AuthStatus get status => _status;
  Set<AuthRole> get roles => _roles;
  bool get isGuest => _status == AuthStatus.guest;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isAdmin => _roles.contains(AuthRole.admin);
  bool get sessionExpired => _sessionExpired;

  void signIn(Set<AuthRole> roles) {
    _status = AuthStatus.authenticated;
    _roles = Set<AuthRole>.unmodifiable(roles);
    _sessionExpired = false;
    notifyListeners();
  }

  void signOut() {
    _status = AuthStatus.guest;
    _roles = const <AuthRole>{};
    _sessionExpired = false;
    notifyListeners();
  }

  void expireSession() {
    _status = AuthStatus.guest;
    _roles = const <AuthRole>{};
    _sessionExpired = true;
    notifyListeners();
  }

  void consumeSessionExpiredFlag() {
    if (!_sessionExpired) {
      return;
    }

    _sessionExpired = false;
    notifyListeners();
  }
}
