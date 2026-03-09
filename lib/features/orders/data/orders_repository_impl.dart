import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import '../domain/orders_entity.dart';
import '../domain/orders_repository.dart';
import 'orders_api.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl(this._api);
  final OrdersApi _api;

  @override
  Future<List<OrdersEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos.map((dto) => OrdersEntity(id: dto.id)).toList(growable: false);
  }

  @override
  Future<Result<OrderEntity>> checkout({required String cartId, required String addressId, required String paymentMethod}) async =>
      const Failure('Not implemented');

  @override
  Future<Result<OrderEntity>> confirmCod({required String orderId, required String confirmCode}) async =>
      Failure('Not implemented');

  @override
  Future<Result<OrderEntity>> get(String orderId) async =>
      Success(OrderEntity(id: orderId, status: 'pending', total: 0));

  @override
  Future<Result<String>> getStatus(String orderId) async => const Success('pending');

  @override
  Future<Result<PageResponse<OrderEntity>>> list(PageRequest request) async =>
      const Success(PageResponse(items: [], page: 1, perPage: 20, total: 0));
}
