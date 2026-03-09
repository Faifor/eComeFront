class CategoryEntity {
  const CategoryEntity({required this.id, required this.name});
  final String id;
  final String name;
}

class ProductEntity {
  const ProductEntity({required this.id, required this.name, required this.categoryId});
  final String id;
  final String name;
  final String categoryId;
}

class VariantEntity {
  const VariantEntity({required this.id, required this.productId, required this.sku});
  final String id;
  final String productId;
  final String sku;
}

class AttributeEntity {
  const AttributeEntity({required this.id, required this.name, required this.value});
  final String id;
  final String name;
  final String value;
}

class InventoryEntity {
  const InventoryEntity({required this.variantId, required this.available});
  final String variantId;
  final int available;
}

class CatalogEntity {
  const CatalogEntity({required this.id});
  final String id;
}
