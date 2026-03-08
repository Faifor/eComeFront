import 'auth_entity.dart';
import 'auth_repository.dart';

class GetAuthItemsUseCase {
  GetAuthItemsUseCase(this._repository);

  final AuthRepository _repository;

  Future<List<AuthEntity>> call() {
    return _repository.getAll();
  }
}
