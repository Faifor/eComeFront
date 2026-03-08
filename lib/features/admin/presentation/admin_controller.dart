import '../domain/get_admin_items_use_case.dart';

class AdminController {
  AdminController(this._getItems);

  final GetAdminItemsUseCase _getItems;

  Future<void> load() async {
    await _getItems();
  }
}
