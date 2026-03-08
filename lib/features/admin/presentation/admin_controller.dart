import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/admin_entity.dart';
import '../domain/get_admin_items_use_case.dart';

class AdminController extends StateNotifier<AsyncValue<List<AdminEntity>>> {
  AdminController(this._getItems) : super(const AsyncLoading()) {
    load();
  }

  final GetAdminItemsUseCase _getItems;

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getItems.call);
  }
}
