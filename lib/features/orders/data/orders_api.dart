import '../../../core/network/api_client.dart';
import 'orders_dto.dart';

class OrdersApi {
  OrdersApi(this._apiClient);

  final ApiClient _apiClient;

  Future<List<OrdersDto>> fetchAll() async {
    await _apiClient.get('/orders');
    return const [];
  }
}
