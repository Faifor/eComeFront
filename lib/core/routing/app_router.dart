import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_shell.dart';
import 'routes.dart';

class AppRouter {
  late final RouterConfig<Object> config = GoRouter(
    initialLocation: RoutePaths.login,
    routes: [
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const _RouteScreen(title: 'Login'),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => const _RouteScreen(title: 'Register'),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(
          location: state.uri.path,
          child: child,
        ),
        routes: [
          _buildRoute(RoutePaths.profile, RouteNames.profile, 'Profile'),
          _buildRoute(RoutePaths.catalog, RouteNames.catalog, 'Catalog'),
          _buildRoute(RoutePaths.product, RouteNames.product, 'Product'),
          _buildRoute(RoutePaths.cart, RouteNames.cart, 'Cart'),
          _buildRoute(RoutePaths.checkout, RouteNames.checkout, 'Checkout'),
          _buildRoute(RoutePaths.orders, RouteNames.orders, 'Orders'),
          _buildRoute(
            RoutePaths.orderDetails,
            RouteNames.orderDetails,
            'Order Details',
          ),
          _buildRoute(RoutePaths.dashboard, RouteNames.dashboard, 'Dashboard'),
          _buildRoute(RoutePaths.categories, RouteNames.categories, 'Categories'),
          _buildRoute(RoutePaths.products, RouteNames.products, 'Products'),
          _buildRoute(RoutePaths.skus, RouteNames.skus, 'SKUs'),
          _buildRoute(RoutePaths.inventory, RouteNames.inventory, 'Inventory'),
          _buildRoute(
            RoutePaths.pricingRules,
            RouteNames.pricingRules,
            'Pricing Rules',
          ),
          _buildRoute(RoutePaths.bulk, RouteNames.bulk, 'Bulk'),
          _buildRoute(RoutePaths.import, RouteNames.import, 'Import'),
          _buildRoute(RoutePaths.reports, RouteNames.reports, 'Reports'),
          _buildRoute(
            RoutePaths.apiDiagnostics,
            RouteNames.apiDiagnostics,
            'API Diagnostics',
          ),
        ],
      ),
    ],
  );
}

GoRoute _buildRoute(String path, String name, String title) {
  return GoRoute(
    path: path,
    name: name,
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
