import '../domain/get_auth_items_use_case.dart';

class AuthController {
  AuthController(this._getItems);

  final GetAuthItemsUseCase _getItems;

  Future<void> load() async {
    await _getItems();
  }
}
