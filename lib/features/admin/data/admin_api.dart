import '../../../core/network/api_client.dart';
import 'admin_dto.dart';

class AdminApi {
  AdminApi(this._apiClient);

  final ApiClient _apiClient;

  Future<List<AdminDto>> fetchAll() async {
    await _apiClient.get('/admin');
    return const [];
  }
}
