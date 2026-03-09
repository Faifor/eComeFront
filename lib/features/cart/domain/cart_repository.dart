import '../../../core/utils/result.dart';
import 'cart_entity.dart';

abstract interface class CartRepository {
  Future<Result<CartAggregateEntity>> create({required String userId});
  Future<Result<CartAggregateEntity>> get(String cartId);
  Future<Result<CartAggregateEntity>> updateItem({required String cartId, required String productId, required int quantity});

  Future<List<CartEntity>> getAll();
}
