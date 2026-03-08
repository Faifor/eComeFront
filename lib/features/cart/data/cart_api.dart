import '../../../core/network/api_client.dart';
import 'cart_dto.dart';

class CartApi {
  CartApi(this._apiClient);

  final ApiClient _apiClient;

  Future<List<CartDto>> fetchAll() async {
    await _apiClient.get('/cart');
    return const [];
  }
}
