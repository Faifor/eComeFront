import '../auth/auth_state.dart';
import 'routes.dart';

class RouteGuard {
  String? redirect({required String path, required AuthState authState}) {
    final onPublicRoute = _isPublicRoute(path);

    if (authState.isGuest) {
      if (onPublicRoute || path == RoutePaths.forbidden) {
        return null;
      }

      return _loginLocation(path, expired: authState.sessionExpired);
    }

    if (onPublicRoute) {
      authState.consumeSessionExpiredFlag();
      return RoutePaths.profile;
    }

    if (_isAdminRoute(path) && !authState.isAdmin) {
      return RoutePaths.forbidden;
    }

    authState.consumeSessionExpiredFlag();
    return null;
  }

  bool _isPublicRoute(String path) {
    return path == RoutePaths.login || path == RoutePaths.register;
  }

  bool _isAdminRoute(String path) {
    return path.startsWith('/admin/');
  }

  String _loginLocation(String returnUrl, {required bool expired}) {
    final queryParameters = <String, String>{
      'returnUrl': returnUrl,
      if (expired) 'expired': '1',
    };
    return Uri(path: RoutePaths.login, queryParameters: queryParameters).toString();
  }
}
