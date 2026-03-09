import 'dart:math';

import 'package:dio/dio.dart';

class RequestIdInterceptor extends Interceptor {
  static const requestIdHeader = 'X-Request-ID';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final incomingRequestId = options.headers[requestIdHeader];
    options.headers[requestIdHeader] =
        incomingRequestId?.toString().trim().isNotEmpty == true
            ? incomingRequestId
            : _newRequestId();
    handler.next(options);
  }

  String _newRequestId() {
    final random = Random.secure();
    final entropy = random.nextInt(0x7fffffff).toRadixString(16).padLeft(8, '0');
    final timestamp = DateTime.now().microsecondsSinceEpoch.toRadixString(16);
    return '$timestamp-$entropy';
  }
}
