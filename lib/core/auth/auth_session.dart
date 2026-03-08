import 'token_storage.dart';

class AuthSession {
  AuthSession(this._tokenStorage);

  final TokenStorage _tokenStorage;

  String? get token => _tokenStorage.read();

  bool get isAuthenticated => token != null;

  void open(String token) {
    _tokenStorage.write(token);
  }

  void clear() {
    _tokenStorage.clear();
  }
}
