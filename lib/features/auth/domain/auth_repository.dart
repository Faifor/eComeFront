import 'auth_entity.dart';

abstract interface class AuthRepository {
  Future<List<AuthEntity>> getAll();
}
