import '../domain/get_orders_items_use_case.dart';

class OrdersController {
  OrdersController(this._getItems);

  final GetOrdersItemsUseCase _getItems;

  Future<void> load() async {
    await _getItems();
  }
}
