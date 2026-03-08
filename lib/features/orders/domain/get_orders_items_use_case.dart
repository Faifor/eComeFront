import 'orders_entity.dart';
import 'orders_repository.dart';

class GetOrdersItemsUseCase {
  GetOrdersItemsUseCase(this._repository);

  final OrdersRepository _repository;

  Future<List<OrdersEntity>> call() {
    return _repository.getAll();
  }
}
