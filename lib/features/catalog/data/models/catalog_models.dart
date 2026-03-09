import 'package:json_annotation/json_annotation.dart';

import '../../../../core/network/query/query_builders.dart';

@JsonSerializable()
class CatalogListRequestDto {
  const CatalogListRequestDto({this.pageRequest = const PageRequest()});
  final PageRequest pageRequest;
  Map<String, dynamic> toQuery() => pageRequest.toQuery();
}

@JsonSerializable()
class CategoryDto {
  const CategoryDto({required this.id, required this.name});
  final String id;
  final String name;
  factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(id: json['id'].toString(), name: json['name']?.toString() ?? '');
}

@JsonSerializable()
class ProductDto {
  const ProductDto({required this.id, required this.name, required this.categoryId});
  final String id;
  final String name;
  final String categoryId;
  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
    id: json['id'].toString(),
    name: json['name']?.toString() ?? '',
    categoryId: json['category_id']?.toString() ?? '',
  );
}

@JsonSerializable()
class VariantDto {
  const VariantDto({required this.id, required this.productId, required this.sku});
  final String id;
  final String productId;
  final String sku;
  factory VariantDto.fromJson(Map<String, dynamic> json) => VariantDto(
    id: json['id'].toString(),
    productId: json['product_id']?.toString() ?? '',
    sku: json['sku']?.toString() ?? '',
  );
}

@JsonSerializable()
class AttributeDto {
  const AttributeDto({required this.id, required this.name, required this.value});
  final String id;
  final String name;
  final String value;
  factory AttributeDto.fromJson(Map<String, dynamic> json) => AttributeDto(
    id: json['id'].toString(),
    name: json['name']?.toString() ?? '',
    value: json['value']?.toString() ?? '',
  );
}

@JsonSerializable()
class InventoryDto {
  const InventoryDto({required this.variantId, required this.available});
  final String variantId;
  final int available;
  factory InventoryDto.fromJson(Map<String, dynamic> json) => InventoryDto(
    variantId: json['variant_id']?.toString() ?? '',
    available: (json['available'] as num?)?.toInt() ?? 0,
  );
}
