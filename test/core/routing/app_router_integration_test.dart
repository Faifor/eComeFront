import 'package:ecom_front/core/auth/auth_state.dart';
import 'package:ecom_front/core/routing/app_router.dart';
import 'package:ecom_front/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('guest is redirected to login and admin fallback goes to 403', (
    tester,
  ) async {
    final authState = AuthState();
    final router = AppRouter(authState: authState);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router.config));
    await tester.pumpAndSettle();

    final goRouter = router.config as GoRouter;
    goRouter.go(RoutePaths.dashboard);
    await tester.pumpAndSettle();

    expect(find.text('Login screen'), findsOneWidget);

    authState.signIn({AuthRole.user});
    goRouter.go(RoutePaths.dashboard);
    await tester.pumpAndSettle();

    expect(find.text('403 Forbidden screen'), findsOneWidget);
  });
}
