import 'package:ecom_front/core/auth/auth_state.dart';
import 'package:ecom_front/core/routing/app_router.dart';
import 'package:ecom_front/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('auth flow login -> protected route -> logout', (tester) async {
    final authState = AuthState();
    final router = AppRouter(authState: authState);

    await tester.pumpWidget(MaterialApp.router(routerConfig: router.config));
    await tester.pumpAndSettle();

    final go = router.config as GoRouter;
    go.go(RoutePaths.orders);
    await tester.pumpAndSettle();
    expect(find.text('Login screen'), findsOneWidget);

    authState.signIn({AuthRole.user});
    go.go(RoutePaths.orders);
    await tester.pumpAndSettle();
    expect(find.text('Orders screen'), findsOneWidget);

    authState.signOut();
    go.go(RoutePaths.orders);
    await tester.pumpAndSettle();
    expect(find.text('Login screen'), findsOneWidget);
  });
}
