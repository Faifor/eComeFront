import '../../../core/network/api_client.dart';
import 'catalog_dto.dart';

class CatalogApi {
  CatalogApi(this._apiClient);

  final ApiClient _apiClient;

  Future<List<CatalogDto>> fetchAll() async {
    await _apiClient.get('/catalog');
    return const [];
  }
}
