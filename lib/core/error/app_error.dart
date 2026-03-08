sealed class AppError implements Exception {
  const AppError(this.message);

  final String message;
}

class NetworkError extends AppError {
  const NetworkError(super.message);
}

class UnauthorizedError extends AppError {
  const UnauthorizedError(super.message);
}
