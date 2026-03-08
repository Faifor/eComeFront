import '../domain/get_catalog_items_use_case.dart';

class CatalogController {
  CatalogController(this._getItems);

  final GetCatalogItemsUseCase _getItems;

  Future<void> load() async {
    await _getItems();
  }
}
