import '../../../core/network/api_client.dart';
import 'auth_dto.dart';

class AuthApi {
  AuthApi(this._apiClient);

  final ApiClient _apiClient;

  Future<List<AuthDto>> fetchAll() async {
    await _apiClient.get('/auth');
    return const [];
  }
}
