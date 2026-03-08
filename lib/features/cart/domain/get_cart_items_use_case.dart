import 'cart_entity.dart';
import 'cart_repository.dart';

class GetCartItemsUseCase {
  GetCartItemsUseCase(this._repository);

  final CartRepository _repository;

  Future<List<CartEntity>> call() {
    return _repository.getAll();
  }
}
