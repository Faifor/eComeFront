import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/catalog_entity.dart';
import '../domain/get_catalog_items_use_case.dart';

class CatalogController extends StateNotifier<AsyncValue<List<CatalogEntity>>> {
  CatalogController(this._getItems) : super(const AsyncLoading()) {
    load();
  }

  final GetCatalogItemsUseCase _getItems;

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getItems.call);
  }
}
