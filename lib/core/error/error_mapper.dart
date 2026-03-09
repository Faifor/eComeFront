import 'package:dio/dio.dart';

import 'app_error.dart';

class ErrorMapper {
  const ErrorMapper();

  AppError map(Object error) {
    if (error is AppError) {
      return error;
    }

    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode;
      final payload = response?.data;
      final details = payload is Map<String, dynamic>
          ? Map<String, dynamic>.from(payload)
          : null;
      final code = _extractCode(details);
      final message = _extractMessage(details) ?? error.message ?? 'Request failed';

      if (statusCode == 401) {
        return UnauthorizedError(
          message: message,
          statusCode: statusCode,
          code: code,
          details: details,
        );
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return TimeoutError(
          message: message,
          statusCode: statusCode,
          code: code,
          details: details,
        );
      }

      if (statusCode != null && statusCode >= 500) {
        return ServerError(
          message: message,
          statusCode: statusCode,
          code: code,
          details: details,
        );
      }

      return NetworkError(
        message: message,
        statusCode: statusCode,
        code: code,
        details: details,
      );
    }

    return UnknownError(message: error.toString());
  }

  String? _extractCode(Map<String, dynamic>? payload) {
    if (payload == null) {
      return null;
    }

    return payload['code']?.toString() ?? payload['type']?.toString();
  }

  String? _extractMessage(Map<String, dynamic>? payload) {
    if (payload == null) {
      return null;
    }

    return payload['detail']?.toString() ??
        payload['message']?.toString() ??
        payload['title']?.toString() ??
        payload['error']?.toString();
  }
}
