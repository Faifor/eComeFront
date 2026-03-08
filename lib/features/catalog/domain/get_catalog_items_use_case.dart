import 'catalog_entity.dart';
import 'catalog_repository.dart';

class GetCatalogItemsUseCase {
  GetCatalogItemsUseCase(this._repository);

  final CatalogRepository _repository;

  Future<List<CatalogEntity>> call() {
    return _repository.getAll();
  }
}
