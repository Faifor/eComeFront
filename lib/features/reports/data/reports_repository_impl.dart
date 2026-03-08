import '../domain/reports_entity.dart';
import '../domain/reports_repository.dart';
import 'reports_api.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  ReportsRepositoryImpl(this._api);

  final ReportsApi _api;

  @override
  Future<List<ReportsEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos
        .map((dto) => ReportsEntity(id: dto.id))
        .toList(growable: false);
  }
}
