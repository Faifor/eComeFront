import '../../domain/catalog_entity.dart';
import '../models/catalog_models.dart';

extension CategoryDtoMapper on CategoryDto {
  CategoryEntity toEntity() => CategoryEntity(id: id, name: name);
}

extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() => ProductEntity(id: id, name: name, categoryId: categoryId);
}

extension VariantDtoMapper on VariantDto {
  VariantEntity toEntity() => VariantEntity(id: id, productId: productId, sku: sku);
}

extension AttributeDtoMapper on AttributeDto {
  AttributeEntity toEntity() => AttributeEntity(id: id, name: name, value: value);
}

extension InventoryDtoMapper on InventoryDto {
  InventoryEntity toEntity() => InventoryEntity(variantId: variantId, available: available);
}
