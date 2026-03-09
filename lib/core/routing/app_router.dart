import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecom_front/features/admin/presentation/admin_screen.dart';
import 'package:ecom_front/features/auth/presentation/auth_screen.dart';
import 'package:ecom_front/features/cart/presentation/cart_screen.dart';
import 'package:ecom_front/features/catalog/presentation/catalog_screen.dart';
import 'package:ecom_front/features/orders/presentation/orders_screen.dart';
import 'package:ecom_front/features/pricing/presentation/pricing_screen.dart';
import 'package:ecom_front/features/reports/presentation/reports_screen.dart';

import '../auth/auth_state.dart';
import 'app_shell.dart';
import 'route_guard.dart';
import 'routes.dart';

class AppRouter {
  AppRouter({required AuthState authState}) : _authState = authState;

  final AuthState _authState;
  final RouteGuard _guard = RouteGuard();

  late final RouterConfig<Object> config = GoRouter(
    initialLocation: RoutePaths.login,
    refreshListenable: _authState,
    redirect: (context, state) => _redirect(state),
    routes: [
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        // TODO: Replace placeholder when RegisterScreen is implemented.
        builder: (context, state) => const _RouteScreen(title: 'Register'),
      ),
      GoRoute(
        path: RoutePaths.forbidden,
        name: RouteNames.forbidden,
        // TODO: Replace placeholder when ForbiddenScreen is implemented.
        builder: (context, state) => const _RouteScreen(title: '403 Forbidden'),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(
          location: state.uri.path,
          child: child,
        ),
        routes: [
          _todoRoute(RoutePaths.profile, RouteNames.profile, 'Profile'),
          GoRoute(
            path: RoutePaths.catalog,
            name: RouteNames.catalog,
            builder: (context, state) => const CatalogScreen(),
          ),
          _todoRoute(RoutePaths.product, RouteNames.product, 'Product'),
          GoRoute(
            path: RoutePaths.cart,
            name: RouteNames.cart,
            builder: (context, state) => const CartScreen(),
          ),
          _todoRoute(RoutePaths.checkout, RouteNames.checkout, 'Checkout'),
          GoRoute(
            path: RoutePaths.orders,
            name: RouteNames.orders,
            builder: (context, state) => const OrdersScreen(),
          ),
          _todoRoute(
            RoutePaths.orderDetails,
            RouteNames.orderDetails,
            'Order Details',
          ),
          GoRoute(
            path: RoutePaths.dashboard,
            name: RouteNames.dashboard,
            builder: (context, state) => const AdminScreen(),
          ),
          _todoRoute(RoutePaths.categories, RouteNames.categories, 'Categories'),
          _todoRoute(RoutePaths.products, RouteNames.products, 'Products'),
          _todoRoute(RoutePaths.skus, RouteNames.skus, 'SKUs'),
          _todoRoute(RoutePaths.inventory, RouteNames.inventory, 'Inventory'),
          GoRoute(
            path: RoutePaths.pricingRules,
            name: RouteNames.pricingRules,
            builder: (context, state) => const PricingScreen(),
          ),
          _todoRoute(RoutePaths.bulk, RouteNames.bulk, 'Bulk'),
          _todoRoute(RoutePaths.import, RouteNames.import, 'Import'),
          GoRoute(
            path: RoutePaths.reports,
            name: RouteNames.reports,
            builder: (context, state) => const ReportsScreen(),
          ),
          _todoRoute(
            RoutePaths.apiDiagnostics,
            RouteNames.apiDiagnostics,
            'API Diagnostics',
          ),
        ],
      ),
    ],
  );

  String? _redirect(GoRouterState state) {
    return _guard.redirect(path: state.uri.path, authState: _authState);
  }
}

GoRoute _todoRoute(String path, String name, String title) {
  return GoRoute(
    path: path,
    name: name,
    // TODO: Replace placeholder when dedicated feature screen is implemented.
    builder: (context, state) => _RouteScreen(title: title),
  );
}

class _RouteScreen extends StatelessWidget {
  const _RouteScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$title screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
