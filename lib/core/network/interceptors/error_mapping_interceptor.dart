import 'package:dio/dio.dart';

import '../../error/error_mapper.dart';

class ErrorMappingInterceptor extends Interceptor {
  ErrorMappingInterceptor(this._errorMapper);

  final ErrorMapper _errorMapper;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: _errorMapper.map(err),
        message: err.message,
      ),
    );
  }
}
