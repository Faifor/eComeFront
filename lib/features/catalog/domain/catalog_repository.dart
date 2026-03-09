import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import 'catalog_entity.dart';

abstract interface class CatalogRepository {
  Future<Result<PageResponse<CategoryEntity>>> listCategories(PageRequest request);
  Future<Result<PageResponse<ProductEntity>>> listProducts(PageRequest request);
  Future<Result<PageResponse<VariantEntity>>> listVariants(PageRequest request);
  Future<Result<PageResponse<AttributeEntity>>> listAttributes(PageRequest request);
  Future<Result<PageResponse<InventoryEntity>>> listInventory(PageRequest request);

  Future<List<CatalogEntity>> getAll();
}
