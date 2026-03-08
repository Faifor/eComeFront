import 'admin_entity.dart';
import 'admin_repository.dart';

class GetAdminItemsUseCase {
  GetAdminItemsUseCase(this._repository);

  final AdminRepository _repository;

  Future<List<AdminEntity>> call() {
    return _repository.getAll();
  }
}
