import '../domain/orders_entity.dart';
import '../domain/orders_repository.dart';
import 'orders_api.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl(this._api);

  final OrdersApi _api;

  @override
  Future<List<OrdersEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos
        .map((dto) => OrdersEntity(id: dto.id))
        .toList(growable: false);
  }
}
