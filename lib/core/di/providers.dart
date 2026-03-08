import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/admin/data/admin_api.dart';
import '../../features/admin/data/admin_repository_impl.dart';
import '../../features/admin/domain/get_admin_items_use_case.dart';
import '../../features/admin/presentation/admin_controller.dart';
import '../../features/auth/data/auth_api.dart';
import '../../features/auth/data/auth_repository_impl.dart';
import '../../features/auth/domain/get_auth_items_use_case.dart';
import '../../features/auth/presentation/auth_controller.dart';
import '../../features/cart/data/cart_api.dart';
import '../../features/cart/data/cart_repository_impl.dart';
import '../../features/cart/domain/get_cart_items_use_case.dart';
import '../../features/cart/presentation/cart_controller.dart';
import '../../features/catalog/data/catalog_api.dart';
import '../../features/catalog/data/catalog_repository_impl.dart';
import '../../features/catalog/domain/get_catalog_items_use_case.dart';
import '../../features/catalog/presentation/catalog_controller.dart';
import '../../features/orders/data/orders_api.dart';
import '../../features/orders/data/orders_repository_impl.dart';
import '../../features/orders/domain/get_orders_items_use_case.dart';
import '../../features/orders/presentation/orders_controller.dart';
import '../../features/pricing/data/pricing_api.dart';
import '../../features/pricing/data/pricing_repository_impl.dart';
import '../../features/pricing/domain/get_pricing_items_use_case.dart';
import '../../features/pricing/presentation/pricing_controller.dart';
import '../../features/reports/data/reports_api.dart';
import '../../features/reports/data/reports_repository_impl.dart';
import '../../features/reports/domain/get_reports_items_use_case.dart';
import '../../features/reports/presentation/reports_controller.dart';
import '../../features/admin/domain/admin_entity.dart';
import '../../features/auth/domain/auth_entity.dart';
import '../../features/cart/domain/cart_entity.dart';
import '../../features/catalog/domain/catalog_entity.dart';
import '../../features/orders/domain/orders_entity.dart';
import '../../features/pricing/domain/pricing_entity.dart';
import '../../features/reports/domain/reports_entity.dart';
import '../auth/auth_session.dart';
import '../auth/token_storage.dart';
import '../config/env_config.dart';
import '../network/api_client.dart';

final envConfigProvider = Provider<EnvConfig>((ref) {
  throw UnimplementedError('Override envConfigProvider in ProviderScope');
});

final dioProvider = Provider<Dio>((ref) {
  final envConfig = ref.watch(envConfigProvider);
  return Dio(BaseOptions(baseUrl: envConfig.apiBaseUrl));
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

final authSessionProvider = Provider<AuthSession>((ref) {
  return AuthSession(ref.watch(tokenStorageProvider));
});

final authApiProvider = Provider<AuthApi>((ref) => AuthApi(ref.watch(apiClientProvider)));
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(ref.watch(authApiProvider));
});
final getAuthItemsUseCaseProvider = Provider<GetAuthItemsUseCase>((ref) {
  return GetAuthItemsUseCase(ref.watch(authRepositoryProvider));
});
final authStateProvider = StateNotifierProvider<AuthController, AsyncValue<List<AuthEntity>>>(
  (ref) => AuthController(ref.watch(getAuthItemsUseCaseProvider)),
);

final catalogApiProvider =
    Provider<CatalogApi>((ref) => CatalogApi(ref.watch(apiClientProvider)));
final catalogRepositoryProvider = Provider<CatalogRepositoryImpl>((ref) {
  return CatalogRepositoryImpl(ref.watch(catalogApiProvider));
});
final getCatalogItemsUseCaseProvider = Provider<GetCatalogItemsUseCase>((ref) {
  return GetCatalogItemsUseCase(ref.watch(catalogRepositoryProvider));
});
final catalogStateProvider =
    StateNotifierProvider<CatalogController, AsyncValue<List<CatalogEntity>>>(
      (ref) => CatalogController(ref.watch(getCatalogItemsUseCaseProvider)),
    );

final pricingApiProvider =
    Provider<PricingApi>((ref) => PricingApi(ref.watch(apiClientProvider)));
final pricingRepositoryProvider = Provider<PricingRepositoryImpl>((ref) {
  return PricingRepositoryImpl(ref.watch(pricingApiProvider));
});
final getPricingItemsUseCaseProvider = Provider<GetPricingItemsUseCase>((ref) {
  return GetPricingItemsUseCase(ref.watch(pricingRepositoryProvider));
});
final pricingStateProvider =
    StateNotifierProvider<PricingController, AsyncValue<List<PricingEntity>>>(
      (ref) => PricingController(ref.watch(getPricingItemsUseCaseProvider)),
    );

final cartApiProvider = Provider<CartApi>((ref) => CartApi(ref.watch(apiClientProvider)));
final cartRepositoryProvider = Provider<CartRepositoryImpl>((ref) {
  return CartRepositoryImpl(ref.watch(cartApiProvider));
});
final getCartItemsUseCaseProvider = Provider<GetCartItemsUseCase>((ref) {
  return GetCartItemsUseCase(ref.watch(cartRepositoryProvider));
});
final cartStateProvider = StateNotifierProvider<CartController, AsyncValue<List<CartEntity>>>(
  (ref) => CartController(ref.watch(getCartItemsUseCaseProvider)),
);

final ordersApiProvider =
    Provider<OrdersApi>((ref) => OrdersApi(ref.watch(apiClientProvider)));
final ordersRepositoryProvider = Provider<OrdersRepositoryImpl>((ref) {
  return OrdersRepositoryImpl(ref.watch(ordersApiProvider));
});
final getOrdersItemsUseCaseProvider = Provider<GetOrdersItemsUseCase>((ref) {
  return GetOrdersItemsUseCase(ref.watch(ordersRepositoryProvider));
});
final ordersStateProvider =
    StateNotifierProvider<OrdersController, AsyncValue<List<OrdersEntity>>>(
      (ref) => OrdersController(ref.watch(getOrdersItemsUseCaseProvider)),
    );

final adminApiProvider = Provider<AdminApi>((ref) => AdminApi(ref.watch(apiClientProvider)));
final adminRepositoryProvider = Provider<AdminRepositoryImpl>((ref) {
  return AdminRepositoryImpl(ref.watch(adminApiProvider));
});
final getAdminItemsUseCaseProvider = Provider<GetAdminItemsUseCase>((ref) {
  return GetAdminItemsUseCase(ref.watch(adminRepositoryProvider));
});
final adminStateProvider =
    StateNotifierProvider<AdminController, AsyncValue<List<AdminEntity>>>(
      (ref) => AdminController(ref.watch(getAdminItemsUseCaseProvider)),
    );

final reportsApiProvider =
    Provider<ReportsApi>((ref) => ReportsApi(ref.watch(apiClientProvider)));
final reportsRepositoryProvider = Provider<ReportsRepositoryImpl>((ref) {
  return ReportsRepositoryImpl(ref.watch(reportsApiProvider));
});
final getReportsItemsUseCaseProvider = Provider<GetReportsItemsUseCase>((ref) {
  return GetReportsItemsUseCase(ref.watch(reportsRepositoryProvider));
});
final reportsStateProvider =
    StateNotifierProvider<ReportsController, AsyncValue<List<ReportsEntity>>>(
      (ref) => ReportsController(ref.watch(getReportsItemsUseCaseProvider)),
    );
