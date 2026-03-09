import '../../../core/utils/result.dart';
import '../domain/auth_entity.dart';
import '../domain/auth_repository.dart';
import 'auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._api);

  final AuthApi _api;

  @override
  Future<List<AuthEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos.map((dto) => AuthEntity(id: dto.id, email: '', name: '')).toList(growable: false);
  }

  @override
  Future<Result<AuthSessionEntity>> login({required String email, required String password}) async =>
      const Failure('Not implemented');

  @override
  Future<Result<void>> logout() async => const Success(null);

  @override
  Future<Result<AuthSessionEntity>> refresh({required String refreshToken}) async => const Failure('Not implemented');

  @override
  Future<Result<AuthSessionEntity>> register({required String email, required String password, required String name}) async =>
      const Failure('Not implemented');

  @override
  Future<Result<AuthUser>> updateProfile({String? name, String? phone}) async => const Failure('Not implemented');

  @override
  Future<Result<AuthUser>> getMe() async => const Failure('Not implemented');
}
