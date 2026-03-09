import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import 'catalog_entity.dart';
import 'catalog_repository.dart';

class ListCategoriesUseCase {
  const ListCategoriesUseCase(this._repository);
  final CatalogRepository _repository;
  Future<Result<PageResponse<CategoryEntity>>> call(PageRequest request) => _repository.listCategories(request);
}

class ListProductsUseCase {
  const ListProductsUseCase(this._repository);
  final CatalogRepository _repository;
  Future<Result<PageResponse<ProductEntity>>> call(PageRequest request) => _repository.listProducts(request);
}

class ListVariantsUseCase {
  const ListVariantsUseCase(this._repository);
  final CatalogRepository _repository;
  Future<Result<PageResponse<VariantEntity>>> call(PageRequest request) => _repository.listVariants(request);
}

class ListAttributesUseCase {
  const ListAttributesUseCase(this._repository);
  final CatalogRepository _repository;
  Future<Result<PageResponse<AttributeEntity>>> call(PageRequest request) => _repository.listAttributes(request);
}

class ListInventoryUseCase {
  const ListInventoryUseCase(this._repository);
  final CatalogRepository _repository;
  Future<Result<PageResponse<InventoryEntity>>> call(PageRequest request) => _repository.listInventory(request);
}
