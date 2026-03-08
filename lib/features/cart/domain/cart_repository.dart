import 'cart_entity.dart';

abstract interface class CartRepository {
  Future<List<CartEntity>> getAll();
}
