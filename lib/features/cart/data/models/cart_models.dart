import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateCartRequestDto {
  const CreateCartRequestDto({required this.userId});
  final String userId;
  Map<String, dynamic> toJson() => {'user_id': userId};
}

@JsonSerializable()
class UpdateCartItemRequestDto {
  const UpdateCartItemRequestDto({required this.productId, required this.quantity});
  final String productId;
  final int quantity;
  Map<String, dynamic> toJson() => {'product_id': productId, 'quantity': quantity};
}

@JsonSerializable()
class CartItemDto {
  const CartItemDto({required this.productId, required this.quantity});
  final String productId;
  final int quantity;
  factory CartItemDto.fromJson(Map<String, dynamic> json) => CartItemDto(
    productId: json['product_id']?.toString() ?? '',
    quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  );
}

@JsonSerializable()
class CartDto {
  const CartDto({required this.id, required this.items});
  final String id;
  final List<CartItemDto> items;
  factory CartDto.fromJson(Map<String, dynamic> json) => CartDto(
    id: json['id'].toString(),
    items: ((json['items'] as List?) ?? const [])
        .map((item) => CartItemDto.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList(growable: false),
  );
}
