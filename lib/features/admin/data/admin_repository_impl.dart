import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import '../domain/admin_entity.dart';
import '../domain/admin_repository.dart';
import 'admin_api.dart';

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl(this._api);
  final AdminApi _api;

  @override
  Future<List<AdminEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos.map((dto) => AdminEntity(id: dto.id)).toList(growable: false);
  }

  @override
  Future<Result<List<AdminItemEntity>>> bulk({required List<String> ids, required String action}) async =>
      const Success([]);

  @override
  Future<Result<AdminItemEntity>> create(AdminItemEntity item) async => Success(item);

  @override
  Future<Result<void>> delete(String id) async => const Success(null);

  @override
  Future<Result<int>> import({required String source, required String format}) async => const Success(0);

  @override
  Future<Result<PageResponse<AdminItemEntity>>> list(PageRequest request) async =>
      const Success(PageResponse(items: [], page: 1, perPage: 20, total: 0));

  @override
  Future<Result<AdminItemEntity>> read(String id) async => Success(AdminItemEntity(id: id, name: ''));

  @override
  Future<Result<List<AdminReportEntity>>> reports(PageRequest request) async => const Success([]);

  @override
  Future<Result<AdminItemEntity>> update(AdminItemEntity item) async => Success(item);
}
