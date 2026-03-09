import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import 'orders_entity.dart';
import 'orders_repository.dart';

class CheckoutUseCase {
  const CheckoutUseCase(this._repository);
  final OrdersRepository _repository;
  Future<Result<OrderEntity>> call({required String cartId, required String addressId, required String paymentMethod}) =>
      _repository.checkout(cartId: cartId, addressId: addressId, paymentMethod: paymentMethod);
}

class ListOrdersUseCase {
  const ListOrdersUseCase(this._repository);
  final OrdersRepository _repository;
  Future<Result<PageResponse<OrderEntity>>> call(PageRequest request) => _repository.list(request);
}

class GetOrderUseCase {
  const GetOrderUseCase(this._repository);
  final OrdersRepository _repository;
  Future<Result<OrderEntity>> call(String orderId) => _repository.get(orderId);
}

class GetOrderStatusUseCase {
  const GetOrderStatusUseCase(this._repository);
  final OrdersRepository _repository;
  Future<Result<String>> call(String orderId) => _repository.getStatus(orderId);
}

class ConfirmCodUseCase {
  const ConfirmCodUseCase(this._repository);
  final OrdersRepository _repository;
  Future<Result<OrderEntity>> call({required String orderId, required String confirmCode}) =>
      _repository.confirmCod(orderId: orderId, confirmCode: confirmCode);
}
