import '../domain/catalog_entity.dart';
import '../domain/catalog_repository.dart';
import 'catalog_api.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._api);

  final CatalogApi _api;

  @override
  Future<List<CatalogEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos
        .map((dto) => CatalogEntity(id: dto.id))
        .toList(growable: false);
  }
}
