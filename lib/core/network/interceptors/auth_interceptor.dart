import 'package:dio/dio.dart';

import '../../auth/auth_session.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._authSession);

  final AuthSession _authSession;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = _authSession.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
