import '../domain/auth_entity.dart';
import '../domain/auth_repository.dart';
import 'auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._api);

  final AuthApi _api;

  @override
  Future<List<AuthEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos
        .map((dto) => AuthEntity(id: dto.id))
        .toList(growable: false);
  }
}
