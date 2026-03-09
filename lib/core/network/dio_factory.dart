import 'package:dio/dio.dart';

import '../auth/auth_session.dart';
import '../error/error_mapper.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_mapping_interceptor.dart';
import 'interceptors/refresh_token_interceptor.dart';
import 'interceptors/request_id_interceptor.dart';

class DioFactory {
  const DioFactory();

  Dio create({
    required String baseUrl,
    required AuthSession authSession,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll([
      RequestIdInterceptor(),
      AuthInterceptor(authSession),
      RefreshTokenInterceptor(dio: dio, authSession: authSession),
      ErrorMappingInterceptor(const ErrorMapper()),
    ]);

    return dio;
  }
}
