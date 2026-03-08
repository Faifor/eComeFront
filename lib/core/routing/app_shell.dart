import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.location,
  });

  final Widget child;
  final String location;

  bool get _isAdminRoute => location.startsWith('/admin');

  @override
  Widget build(BuildContext context) {
    final menuItems = _isAdminRoute ? _adminMenuItems : _userMenuItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isAdminRoute ? 'Admin area' : 'User area'),
      ),
      body: Row(
        children: [
          Container(
            width: 280,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: ListView(
              children: [
                const SizedBox(height: 12),
                const ListTile(
                  title: Text('Role-based navigation'),
                  subtitle: Text('Switch role by opening the corresponding route.'),
                ),
                const Divider(),
                ...menuItems.map(
                  (item) => ListTile(
                    selected: location == item.path,
                    leading: Icon(item.icon),
                    title: Text(item.title),
                    onTap: () => context.go(item.path),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem({
    required this.title,
    required this.path,
    required this.icon,
  });

  final String title;
  final String path;
  final IconData icon;
}

const _userMenuItems = <_MenuItem>[
  _MenuItem(title: 'Profile', path: RoutePaths.profile, icon: Icons.person_outline),
  _MenuItem(title: 'Catalog', path: RoutePaths.catalog, icon: Icons.storefront_outlined),
  _MenuItem(title: 'Product', path: RoutePaths.product, icon: Icons.inventory_2_outlined),
  _MenuItem(title: 'Cart', path: RoutePaths.cart, icon: Icons.shopping_cart_outlined),
  _MenuItem(title: 'Checkout', path: RoutePaths.checkout, icon: Icons.payment_outlined),
  _MenuItem(title: 'Orders', path: RoutePaths.orders, icon: Icons.receipt_long_outlined),
  _MenuItem(
    title: 'Order details',
    path: RoutePaths.orderDetails,
    icon: Icons.assignment_outlined,
  ),
];

const _adminMenuItems = <_MenuItem>[
  _MenuItem(title: 'Dashboard', path: RoutePaths.dashboard, icon: Icons.dashboard_outlined),
  _MenuItem(title: 'Categories', path: RoutePaths.categories, icon: Icons.category_outlined),
  _MenuItem(title: 'Products', path: RoutePaths.products, icon: Icons.shopping_bag_outlined),
  _MenuItem(title: 'SKUs', path: RoutePaths.skus, icon: Icons.qr_code_outlined),
  _MenuItem(title: 'Inventory', path: RoutePaths.inventory, icon: Icons.warehouse_outlined),
  _MenuItem(
    title: 'Pricing rules',
    path: RoutePaths.pricingRules,
    icon: Icons.price_change_outlined,
  ),
  _MenuItem(title: 'Bulk', path: RoutePaths.bulk, icon: Icons.copy_all_outlined),
  _MenuItem(title: 'Import', path: RoutePaths.import, icon: Icons.upload_file_outlined),
  _MenuItem(title: 'Reports', path: RoutePaths.reports, icon: Icons.bar_chart_outlined),
  _MenuItem(
    title: 'API diagnostics',
    path: RoutePaths.apiDiagnostics,
    icon: Icons.health_and_safety_outlined,
  ),
];
