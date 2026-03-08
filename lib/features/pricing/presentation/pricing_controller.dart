import '../domain/get_pricing_items_use_case.dart';

class PricingController {
  PricingController(this._getItems);

  final GetPricingItemsUseCase _getItems;

  Future<void> load() async {
    await _getItems();
  }
}
