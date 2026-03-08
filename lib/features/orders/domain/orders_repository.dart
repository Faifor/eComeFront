import 'orders_entity.dart';

abstract interface class OrdersRepository {
  Future<List<OrdersEntity>> getAll();
}
