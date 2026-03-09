import '../../../core/utils/result.dart';
import 'auth_entity.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSessionEntity>> register({required String email, required String password, required String name});

  Future<Result<AuthSessionEntity>> login({required String email, required String password});

  Future<Result<AuthSessionEntity>> refresh({required String refreshToken});

  Future<Result<AuthUser>> getMe();

  Future<Result<AuthUser>> updateProfile({String? name, String? phone});

  Future<Result<void>> logout();
  Future<List<AuthEntity>> getAll();
}
