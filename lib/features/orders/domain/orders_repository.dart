import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import 'orders_entity.dart';

abstract interface class OrdersRepository {
  Future<Result<OrderEntity>> checkout({required String cartId, required String addressId, required String paymentMethod});
  Future<Result<PageResponse<OrderEntity>>> list(PageRequest request);
  Future<Result<OrderEntity>> get(String orderId);
  Future<Result<String>> getStatus(String orderId);
  Future<Result<OrderEntity>> confirmCod({required String orderId, required String confirmCode});

  Future<List<OrdersEntity>> getAll();
}
