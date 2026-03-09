import 'package:json_annotation/json_annotation.dart';

import '../../../../core/network/query/query_builders.dart';

@JsonSerializable()
class CheckoutRequestDto {
  const CheckoutRequestDto({required this.cartId, required this.addressId, required this.paymentMethod});
  final String cartId;
  final String addressId;
  final String paymentMethod;
  Map<String, dynamic> toJson() => {'cart_id': cartId, 'address_id': addressId, 'payment_method': paymentMethod};
}

@JsonSerializable()
class CodConfirmRequestDto {
  const CodConfirmRequestDto({required this.orderId, required this.confirmCode});
  final String orderId;
  final String confirmCode;
  Map<String, dynamic> toJson() => {'order_id': orderId, 'confirm_code': confirmCode};
}

@JsonSerializable()
class OrdersListRequestDto {
  const OrdersListRequestDto({this.pageRequest = const PageRequest()});
  final PageRequest pageRequest;
  Map<String, dynamic> toQuery() => pageRequest.toQuery();
}

@JsonSerializable()
class OrderDto {
  const OrderDto({required this.id, required this.status, required this.total});
  final String id;
  final String status;
  final double total;
  factory OrderDto.fromJson(Map<String, dynamic> json) => OrderDto(
    id: json['id'].toString(),
    status: json['status']?.toString() ?? '',
    total: (json['total'] as num?)?.toDouble() ?? 0,
  );
}
