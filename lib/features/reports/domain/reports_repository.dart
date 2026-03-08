import 'reports_entity.dart';

abstract interface class ReportsRepository {
  Future<List<ReportsEntity>> getAll();
}
