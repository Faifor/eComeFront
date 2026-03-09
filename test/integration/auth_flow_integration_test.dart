import 'package:ecom_front/core/auth/auth_state.dart';
import 'package:ecom_front/core/di/providers.dart';
import 'package:ecom_front/core/routing/app_router.dart';
import 'package:ecom_front/core/routing/routes.dart';
import 'package:ecom_front/features/orders/domain/orders_entity.dart';
import 'package:ecom_front/features/orders/presentation/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('auth flow login -> protected route -> logout', (tester) async {
    final authState = AuthState();
    final router = AppRouter(authState: authState);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ordersStateProvider.overrideWith(
            (ref) => _TestOrdersController(const [OrdersEntity(id: 'order-1')]),
          ),
        ],
        child: MaterialApp.router(routerConfig: router.config),
      ),
    );
    await tester.pumpAndSettle();

    final go = router.config as GoRouter;
    go.go(RoutePaths.orders);
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);

    authState.signIn({AuthRole.user});
    go.go(RoutePaths.orders);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('orders_list')), findsOneWidget);

    authState.signOut();
    go.go(RoutePaths.orders);
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
  });
}

class _TestOrdersController extends OrdersController {
  _TestOrdersController(List<OrdersEntity> items) : _items = items, super(() async => items);

  final List<OrdersEntity> _items;

  @override
  Future<void> load() async {
    state = AsyncValue.data(_items);
  }
}
