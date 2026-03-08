import '../../../core/network/api_client.dart';
import 'pricing_dto.dart';

class PricingApi {
  PricingApi(this._apiClient);

  final ApiClient _apiClient;

  Future<List<PricingDto>> fetchAll() async {
    await _apiClient.get('/pricing');
    return const [];
  }
}
