import '../domain/get_reports_items_use_case.dart';

class ReportsController {
  ReportsController(this._getItems);

  final GetReportsItemsUseCase _getItems;

  Future<void> load() async {
    await _getItems();
  }
}
