import '../app_error.dart';
import '../error_mapper.dart';

class OperationErrorMapper {
  const OperationErrorMapper(this._errorMapper);

  final ErrorMapper _errorMapper;

  AppError map(String operation, Object error) {
    final mapped = _errorMapper.map(error);
    return NetworkError(
      message: 'Operation "$operation" failed: ${mapped.message}',
      code: mapped.code,
      statusCode: mapped.statusCode,
      details: mapped.details,
    );
  }
}
