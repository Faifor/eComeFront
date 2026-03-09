import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import '../domain/catalog_entity.dart';
import '../domain/catalog_repository.dart';
import 'catalog_api.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._api);
  final CatalogApi _api;

  @override
  Future<List<CatalogEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos.map((dto) => CatalogEntity(id: dto.id)).toList(growable: false);
  }

  @override
  Future<Result<PageResponse<AttributeEntity>>> listAttributes(PageRequest request) async =>
      const Success(PageResponse(items: [], page: 1, perPage: 20, total: 0));

  @override
  Future<Result<PageResponse<CategoryEntity>>> listCategories(PageRequest request) async =>
      const Success(PageResponse(items: [], page: 1, perPage: 20, total: 0));

  @override
  Future<Result<PageResponse<InventoryEntity>>> listInventory(PageRequest request) async =>
      const Success(PageResponse(items: [], page: 1, perPage: 20, total: 0));

  @override
  Future<Result<PageResponse<ProductEntity>>> listProducts(PageRequest request) async =>
      const Success(PageResponse(items: [], page: 1, perPage: 20, total: 0));

  @override
  Future<Result<PageResponse<VariantEntity>>> listVariants(PageRequest request) async =>
      const Success(PageResponse(items: [], page: 1, perPage: 20, total: 0));
}
