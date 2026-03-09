import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import 'admin_entity.dart';

abstract interface class AdminRepository {
  Future<Result<AdminItemEntity>> create(AdminItemEntity item);
  Future<Result<AdminItemEntity>> read(String id);
  Future<Result<AdminItemEntity>> update(AdminItemEntity item);
  Future<Result<void>> delete(String id);
  Future<Result<PageResponse<AdminItemEntity>>> list(PageRequest request);
  Future<Result<List<AdminItemEntity>>> bulk({required List<String> ids, required String action});
  Future<Result<int>> import({required String source, required String format});
  Future<Result<List<AdminReportEntity>>> reports(PageRequest request);

  Future<List<AdminEntity>> getAll();
}
