import 'package:ecom_front/core/auth/auth_state.dart';
import 'package:ecom_front/core/routing/route_guard.dart';
import 'package:ecom_front/core/routing/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RouteGuard', () {
    final guard = RouteGuard();

    test('allows guest on public route', () {
      final authState = AuthState();

      final redirect = guard.redirect(path: RoutePaths.login, authState: authState);

      expect(redirect, isNull);
    });

    test('redirects guest to login with returnUrl', () {
      final authState = AuthState();

      final redirect = guard.redirect(path: RoutePaths.catalog, authState: authState);

      expect(redirect, '/login?returnUrl=%2Fcatalog');
    });

    test('redirects non-admin away from admin route to forbidden', () {
      final authState = AuthState()..signIn({AuthRole.user});

      final redirect = guard.redirect(path: RoutePaths.dashboard, authState: authState);

      expect(redirect, RoutePaths.forbidden);
    });

    test('allows admin on admin route', () {
      final authState = AuthState()..signIn({AuthRole.admin});

      final redirect = guard.redirect(path: RoutePaths.dashboard, authState: authState);

      expect(redirect, isNull);
    });

    test('adds expired flag for expired guest session', () {
      final authState = AuthState()..expireSession();

      final redirect = guard.redirect(path: RoutePaths.orders, authState: authState);

      expect(redirect, '/login?returnUrl=%2Forders&expired=1');
    });
  });
}
