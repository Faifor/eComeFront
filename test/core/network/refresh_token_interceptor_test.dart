import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ecom_front/core/auth/auth_session.dart';
import 'package:ecom_front/core/network/api_client.dart';
import 'package:ecom_front/core/network/interceptors/refresh_token_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ecom_front/core/auth/token_storage.dart';

class _InMemoryTokenStorage implements TokenStorage {
  String? _access;
  String? _refresh;

  @override
  void clear() {
    _access = null;
    _refresh = null;
  }

  @override
  String? readAccessToken() => _access;

  @override
  String? readRefreshToken() => _refresh;

  @override
  void write({required String accessToken, String? refreshToken}) {
    _access = accessToken;
    _refresh = refreshToken;
  }
}

class _FakeAdapter implements HttpClientAdapter {
  int refreshCalls = 0;
  int protectedCalls = 0;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path == '/auth/refresh') {
      refreshCalls++;
      return ResponseBody.fromString(
        jsonEncode({'accessToken': 'new-access', 'refreshToken': 'new-refresh'}),
        200,
        headers: {Headers.contentTypeHeader: ['application/json']},
      );
    }

    if (options.path == '/protected') {
      protectedCalls++;
      if (protectedCalls == 1) {
        return ResponseBody.fromString('{}', 401);
      }
      return ResponseBody.fromString('{"ok":true}', 200);
    }

    return ResponseBody.fromString('{}', 404);
  }
}

void main() {
  test('refreshes token and replays request on 401', () async {
    final adapter = _FakeAdapter();
    final dio = Dio(BaseOptions(validateStatus: (_) => true))..httpClientAdapter = adapter;
    final storage = _InMemoryTokenStorage()..write(accessToken: 'old-access', refreshToken: 'old-refresh');
    final session = AuthSession(storage);

    dio.interceptors.add(
      RefreshTokenInterceptor(dio: dio, authSession: session),
    );

    final response = await dio.get(
      '/protected',
      options: Options(extra: {ApiClient.idempotentExtraKey: true}),
    );

    expect(response.statusCode, 200);
    expect(adapter.refreshCalls, 1);
    expect(session.accessToken, 'new-access');
  });
}
