import '../../../core/network/api_client.dart';
import 'reports_dto.dart';

class ReportsApi {
  ReportsApi(this._apiClient);

  final ApiClient _apiClient;

  Future<List<ReportsDto>> fetchAll() async {
    await _apiClient.get('/reports');
    return const [];
  }
}
