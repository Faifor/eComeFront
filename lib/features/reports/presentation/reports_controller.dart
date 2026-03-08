import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/reports_entity.dart';
import '../domain/get_reports_items_use_case.dart';

class ReportsController extends StateNotifier<AsyncValue<List<ReportsEntity>>> {
  ReportsController(this._getItems) : super(const AsyncLoading()) {
    load();
  }

  final GetReportsItemsUseCase _getItems;

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getItems.call);
  }
}
