import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/orders_entity.dart';
import '../domain/get_orders_items_use_case.dart';

class OrdersController extends StateNotifier<AsyncValue<List<OrdersEntity>>> {
  OrdersController(this._getItems) : super(const AsyncLoading()) {
    load();
  }

  final GetOrdersItemsUseCase _getItems;

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getItems.call);
  }
}
