import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/cart_entity.dart';
import '../domain/get_cart_items_use_case.dart';

class CartController extends StateNotifier<AsyncValue<List<CartEntity>>> {
  CartController(this._getItems) : super(const AsyncLoading()) {
    load();
  }

  final GetCartItemsUseCase _getItems;

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getItems.call);
  }
}
