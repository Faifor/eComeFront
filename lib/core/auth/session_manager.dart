class SessionManager {
  String? _token;

  String? get token => _token;
  bool get isAuthenticated => _token != null;

  void open(String token) {
    _token = token;
  }

  void clear() {
    _token = null;
  }
}
