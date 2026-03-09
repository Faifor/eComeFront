import '../../../core/utils/result.dart';
import 'cart_entity.dart';
import 'cart_repository.dart';

class CreateCartUseCase {
  const CreateCartUseCase(this._repository);
  final CartRepository _repository;
  Future<Result<CartAggregateEntity>> call({required String userId}) => _repository.create(userId: userId);
}

class GetCartUseCase {
  const GetCartUseCase(this._repository);
  final CartRepository _repository;
  Future<Result<CartAggregateEntity>> call(String cartId) => _repository.get(cartId);
}

class UpdateCartItemUseCase {
  const UpdateCartItemUseCase(this._repository);
  final CartRepository _repository;
  Future<Result<CartAggregateEntity>> call({required String cartId, required String productId, required int quantity}) =>
      _repository.updateItem(cartId: cartId, productId: productId, quantity: quantity);
}
