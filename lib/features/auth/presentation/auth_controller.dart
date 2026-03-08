import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/auth_entity.dart';
import '../domain/get_auth_items_use_case.dart';

class AuthController extends StateNotifier<AsyncValue<List<AuthEntity>>> {
  AuthController(this._getItems) : super(const AsyncLoading()) {
    load();
  }

  final GetAuthItemsUseCase _getItems;

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getItems.call);
  }
}
