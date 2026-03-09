class CartItemEntity {
  const CartItemEntity({required this.productId, required this.quantity});
  final String productId;
  final int quantity;
}

class CartAggregateEntity {
  const CartAggregateEntity({required this.id, required this.items});
  final String id;
  final List<CartItemEntity> items;
}

class CartEntity {
  const CartEntity({required this.id});
  final String id;
}
