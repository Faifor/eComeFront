sealed class AppError implements Exception {
  const AppError({
    required this.message,
    this.code,
    this.statusCode,
    this.details,
  });

  final String message;
  final String? code;
  final int? statusCode;
  final Map<String, dynamic>? details;

  @override
  String toString() =>
      'AppError(message: $message, code: $code, statusCode: $statusCode, details: $details)';
}

class NetworkError extends AppError {
  const NetworkError({
    required super.message,
    super.code,
    super.statusCode,
    super.details,
  });
}

class UnauthorizedError extends AppError {
  const UnauthorizedError({
    super.message = 'Unauthorized',
    super.code,
    super.statusCode,
    super.details,
  });
}

class TimeoutError extends AppError {
  const TimeoutError({
    super.message = 'Request timeout',
    super.code,
    super.statusCode,
    super.details,
  });
}

class ServerError extends AppError {
  const ServerError({
    required super.message,
    super.code,
    super.statusCode,
    super.details,
  });
}

class UnknownError extends AppError {
  const UnknownError({
    super.message = 'Unknown error',
    super.code,
    super.statusCode,
    super.details,
  });
}
