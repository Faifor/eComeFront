import 'package:json_annotation/json_annotation.dart';

import '../../../../core/network/query/query_builders.dart';

@JsonSerializable()
class PricingRuleRequestDto {
  const PricingRuleRequestDto({required this.name, required this.type, required this.value});
  final String name;
  final String type;
  final double value;
  Map<String, dynamic> toJson() => {'name': name, 'type': type, 'value': value};
}

@JsonSerializable()
class PricingCalculateRequestDto {
  const PricingCalculateRequestDto({required this.productId, required this.quantity});
  final String productId;
  final int quantity;
  Map<String, dynamic> toJson() => {'product_id': productId, 'quantity': quantity};
}

@JsonSerializable()
class PricingRuleDto {
  const PricingRuleDto({required this.id, required this.name, required this.type, required this.value});
  final String id;
  final String name;
  final String type;
  final double value;
  factory PricingRuleDto.fromJson(Map<String, dynamic> json) => PricingRuleDto(
    id: json['id'].toString(),
    name: json['name']?.toString() ?? '',
    type: json['type']?.toString() ?? '',
    value: (json['value'] as num?)?.toDouble() ?? 0,
  );
}

@JsonSerializable()
class PricingCalculateResponseDto {
  const PricingCalculateResponseDto({required this.subtotal, required this.discount, required this.total});
  final double subtotal;
  final double discount;
  final double total;
  factory PricingCalculateResponseDto.fromJson(Map<String, dynamic> json) => PricingCalculateResponseDto(
    subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
    discount: (json['discount'] as num?)?.toDouble() ?? 0,
    total: (json['total'] as num?)?.toDouble() ?? 0,
  );
}

@JsonSerializable()
class PricingRuleListRequestDto {
  const PricingRuleListRequestDto({this.pageRequest = const PageRequest()});
  final PageRequest pageRequest;
  Map<String, dynamic> toQuery() => pageRequest.toQuery();
}
