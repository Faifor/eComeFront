class TokenStorage {
  String? _accessToken;
  String? _refreshToken;

  String? readAccessToken() => _accessToken;
  String? readRefreshToken() => _refreshToken;

  void write({
    required String accessToken,
    String? refreshToken,
  }) {
    _accessToken = accessToken;
    if (refreshToken != null) {
      _refreshToken = refreshToken;
    }
  }

  void clear() {
    _accessToken = null;
    _refreshToken = null;
  }
}
