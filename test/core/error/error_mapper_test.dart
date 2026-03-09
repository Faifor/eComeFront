import 'package:dio/dio.dart';
import 'package:ecom_front/core/error/app_error.dart';
import 'package:ecom_front/core/error/error_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorMapper', () {
    const mapper = ErrorMapper();

    test('maps problem+json unauthorized to user friendly message', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/me'),
        response: Response(
          requestOptions: RequestOptions(path: '/me'),
          statusCode: 401,
          data: {
            'type': 'unauthorized',
            'title': 'Unauthorized',
            'detail': 'Session expired. Please login again.',
          },
        ),
      );

      final mapped = mapper.map(exception);

      expect(mapped, isA<UnauthorizedError>());
      expect(mapped.message, 'Session expired. Please login again.');
      expect(mapped.code, 'unauthorized');
    });

    test('maps server errors', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/reports'),
        response: Response(
          requestOptions: RequestOptions(path: '/reports'),
          statusCode: 500,
          data: {'message': 'Internal error'},
        ),
      );

      expect(mapper.map(exception), isA<ServerError>());
    });
  });
}
