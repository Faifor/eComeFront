import 'token_storage.dart';

class AuthSession {
  AuthSession(this._tokenStorage);

  final TokenStorage _tokenStorage;

  String? get accessToken => _tokenStorage.readAccessToken();
  String? get refreshToken => _tokenStorage.readRefreshToken();
  String? get token => accessToken;

  bool get isAuthenticated => accessToken != null;

  void open({
    required String accessToken,
    String? refreshToken,
  }) {
    _tokenStorage.write(accessToken: accessToken, refreshToken: refreshToken);
  }

  void clear() {
    _tokenStorage.clear();
  }
}
