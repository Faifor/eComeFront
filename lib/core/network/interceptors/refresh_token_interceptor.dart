import 'dart:async';

import 'package:dio/dio.dart';

import '../../auth/auth_session.dart';
import '../api_client.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor({
    required Dio dio,
    required AuthSession authSession,
  }) : _dio = dio,
       _authSession = authSession;

  static const _retryFlag = 'retry_attempted_after_refresh';
  static const _idempotentFlag = ApiClient.idempotentExtraKey;

  final Dio _dio;
  final AuthSession _authSession;

  Completer<bool>? _refreshCompleter;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldAttemptRefresh(err)) {
      handler.next(err);
      return;
    }

    final refreshed = await _refreshWithMutex();
    if (!refreshed) {
      handler.next(err);
      return;
    }

    try {
      final replayed = await _replayRequest(err.requestOptions);
      handler.resolve(replayed);
    } on DioException catch (replayedError) {
      handler.next(replayedError);
    }
  }

  bool _shouldAttemptRefresh(DioException err) {
    final requestOptions = err.requestOptions;

    if (err.response?.statusCode != 401) {
      return false;
    }

    if (requestOptions.path == '/auth/refresh') {
      return false;
    }

    if (requestOptions.extra[_retryFlag] == true) {
      return false;
    }

    return _isRetryAllowed(requestOptions);
  }

  bool _isRetryAllowed(RequestOptions requestOptions) {
    if (requestOptions.extra[_idempotentFlag] == true) {
      return true;
    }

    const safeMethods = {'GET', 'HEAD', 'OPTIONS'};
    return safeMethods.contains(requestOptions.method.toUpperCase());
  }

  Future<bool> _refreshWithMutex() async {
    final inFlight = _refreshCompleter;
    if (inFlight != null) {
      return inFlight.future;
    }

    final completer = Completer<bool>();
    _refreshCompleter = completer;

    try {
      final refreshToken = _authSession.refreshToken;
      if (refreshToken == null || refreshToken.isEmpty) {
        _authSession.clear();
        completer.complete(false);
        return false;
      }

      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: <String, dynamic>{'refreshToken': refreshToken},
        options: Options(
          headers: <String, dynamic>{
            'Authorization': null,
          },
          extra: <String, dynamic>{
            _retryFlag: true,
            _idempotentFlag: true,
          },
        ),
      );

      final payload = response.data ?? const <String, dynamic>{};
      final newAccessToken = payload['accessToken']?.toString();
      final newRefreshToken = payload['refreshToken']?.toString() ?? refreshToken;

      if (newAccessToken == null || newAccessToken.isEmpty) {
        _authSession.clear();
        completer.complete(false);
        return false;
      }

      _authSession.open(accessToken: newAccessToken, refreshToken: newRefreshToken);
      completer.complete(true);
      return true;
    } catch (_) {
      _authSession.clear();
      completer.complete(false);
      return false;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<Response<dynamic>> _replayRequest(RequestOptions requestOptions) {
    final headers = Map<String, dynamic>.from(requestOptions.headers);
    final accessToken = _authSession.accessToken;
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return _dio.fetch<dynamic>(
      requestOptions.copyWith(
        headers: headers,
        extra: <String, dynamic>{
          ...requestOptions.extra,
          _retryFlag: true,
        },
      ),
    );
  }
}
