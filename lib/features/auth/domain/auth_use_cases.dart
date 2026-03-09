import '../../../core/utils/result.dart';
import 'auth_entity.dart';
import 'auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);
  final AuthRepository _repository;
  Future<Result<AuthSessionEntity>> call({required String email, required String password, required String name}) =>
      _repository.register(email: email, password: password, name: name);
}

class LoginUseCase {
  const LoginUseCase(this._repository);
  final AuthRepository _repository;
  Future<Result<AuthSessionEntity>> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}

class RefreshSessionUseCase {
  const RefreshSessionUseCase(this._repository);
  final AuthRepository _repository;
  Future<Result<AuthSessionEntity>> call(String refreshToken) => _repository.refresh(refreshToken: refreshToken);
}

class GetMeUseCase {
  const GetMeUseCase(this._repository);
  final AuthRepository _repository;
  Future<Result<AuthUser>> call() => _repository.getMe();
}

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);
  final AuthRepository _repository;
  Future<Result<AuthUser>> call({String? name, String? phone}) => _repository.updateProfile(name: name, phone: phone);
}

class LogoutUseCase {
  const LogoutUseCase(this._repository);
  final AuthRepository _repository;
  Future<Result<void>> call() => _repository.logout();
}
