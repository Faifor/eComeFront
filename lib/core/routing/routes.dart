abstract final class RouteNames {
  // User
  static const login = 'login';
  static const register = 'register';
  static const forbidden = 'forbidden';
  static const profile = 'profile';
  static const catalog = 'catalog';
  static const product = 'product';
  static const cart = 'cart';
  static const checkout = 'checkout';
  static const orders = 'orders';
  static const orderDetails = 'orderDetails';

  // Admin
  static const dashboard = 'dashboard';
  static const categories = 'categories';
  static const products = 'products';
  static const skus = 'skus';
  static const inventory = 'inventory';
  static const pricingRules = 'pricingRules';
  static const bulk = 'bulk';
  static const import = 'import';
  static const reports = 'reports';
  static const apiDiagnostics = 'apiDiagnostics';
}

abstract final class RoutePaths {
  // User
  static const login = '/login';
  static const register = '/register';
  static const forbidden = '/403';
  static const profile = '/profile';
  static const catalog = '/catalog';
  static const product = '/product';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const orders = '/orders';
  static const orderDetails = '/order-details';

  // Admin
  static const dashboard = '/admin/dashboard';
  static const categories = '/admin/categories';
  static const products = '/admin/products';
  static const skus = '/admin/skus';
  static const inventory = '/admin/inventory';
  static const pricingRules = '/admin/pricing-rules';
  static const bulk = '/admin/bulk';
  static const import = '/admin/import';
  static const reports = '/admin/reports';
  static const apiDiagnostics = '/admin/api-diagnostics';
}
