import 'package:dio/dio.dart';

class ApiClient {
  ApiClient(this._dio);

  static const idempotentExtraKey = 'idempotent';

  final Dio _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
      options: _mergeOptions(options, isIdempotent: true),
    );
  }

  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isIdempotent = false,
  }) {
    return _dio.post<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _mergeOptions(options, isIdempotent: isIdempotent),
    );
  }

  Options _mergeOptions(Options? options, {required bool isIdempotent}) {
    final source = options ?? Options();
    final extra = source.extra ?? <String, dynamic>{};
    return source.copyWith(
      extra: <String, dynamic>{
        ...extra,
        idempotentExtraKey: extra[idempotentExtraKey] ?? isIdempotent,
      },
    );
  }
}
