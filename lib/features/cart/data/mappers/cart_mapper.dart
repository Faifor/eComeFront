import '../../domain/cart_entity.dart';
import '../models/cart_models.dart';

extension CartItemDtoMapper on CartItemDto {
  CartItemEntity toEntity() => CartItemEntity(productId: productId, quantity: quantity);
}

extension CartDtoMapper on CartDto {
  CartAggregateEntity toEntity() => CartAggregateEntity(
    id: id,
    items: items.map((item) => item.toEntity()).toList(growable: false),
  );
}
