import '../domain/get_cart_items_use_case.dart';

class CartController {
  CartController(this._getItems);

  final GetCartItemsUseCase _getItems;

  Future<void> load() async {
    await _getItems();
  }
}
