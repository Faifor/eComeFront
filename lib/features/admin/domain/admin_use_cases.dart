import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import 'admin_entity.dart';
import 'admin_repository.dart';

class CreateAdminItemUseCase {
  const CreateAdminItemUseCase(this._repository);
  final AdminRepository _repository;
  Future<Result<AdminItemEntity>> call(AdminItemEntity item) => _repository.create(item);
}

class ReadAdminItemUseCase {
  const ReadAdminItemUseCase(this._repository);
  final AdminRepository _repository;
  Future<Result<AdminItemEntity>> call(String id) => _repository.read(id);
}

class UpdateAdminItemUseCase {
  const UpdateAdminItemUseCase(this._repository);
  final AdminRepository _repository;
  Future<Result<AdminItemEntity>> call(AdminItemEntity item) => _repository.update(item);
}

class DeleteAdminItemUseCase {
  const DeleteAdminItemUseCase(this._repository);
  final AdminRepository _repository;
  Future<Result<void>> call(String id) => _repository.delete(id);
}

class ListAdminItemsUseCase {
  const ListAdminItemsUseCase(this._repository);
  final AdminRepository _repository;
  Future<Result<PageResponse<AdminItemEntity>>> call(PageRequest request) => _repository.list(request);
}

class AdminBulkUseCase {
  const AdminBulkUseCase(this._repository);
  final AdminRepository _repository;
  Future<Result<List<AdminItemEntity>>> call({required List<String> ids, required String action}) =>
      _repository.bulk(ids: ids, action: action);
}

class AdminImportUseCase {
  const AdminImportUseCase(this._repository);
  final AdminRepository _repository;
  Future<Result<int>> call({required String source, required String format}) =>
      _repository.import(source: source, format: format);
}

class AdminReportsUseCase {
  const AdminReportsUseCase(this._repository);
  final AdminRepository _repository;
  Future<Result<List<AdminReportEntity>>> call(PageRequest request) => _repository.reports(request);
}
