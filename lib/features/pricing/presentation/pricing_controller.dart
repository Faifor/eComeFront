import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/pricing_entity.dart';
import '../domain/get_pricing_items_use_case.dart';

class PricingController extends StateNotifier<AsyncValue<List<PricingEntity>>> {
  PricingController(this._getItems) : super(const AsyncLoading()) {
    load();
  }

  final GetPricingItemsUseCase _getItems;

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getItems.call);
  }
}
