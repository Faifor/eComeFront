import '../../../core/utils/result.dart';
import '../domain/cart_entity.dart';
import '../domain/cart_repository.dart';
import 'cart_api.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._api);
  final CartApi _api;

  @override
  Future<List<CartEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos.map((dto) => CartEntity(id: dto.id)).toList(growable: false);
  }

  @override
  Future<Result<CartAggregateEntity>> create({required String userId}) async =>
      const Success(CartAggregateEntity(id: 'new', items: []));

  @override
  Future<Result<CartAggregateEntity>> get(String cartId) async =>
      Success(CartAggregateEntity(id: cartId, items: const []));

  @override
  Future<Result<CartAggregateEntity>> updateItem({required String cartId, required String productId, required int quantity}) async =>
      Success(CartAggregateEntity(id: cartId, items: [CartItemEntity(productId: productId, quantity: quantity)]));
}
