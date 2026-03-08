import 'reports_entity.dart';
import 'reports_repository.dart';

class GetReportsItemsUseCase {
  GetReportsItemsUseCase(this._repository);

  final ReportsRepository _repository;

  Future<List<ReportsEntity>> call() {
    return _repository.getAll();
  }
}
