import 'admin_entity.dart';

abstract interface class AdminRepository {
  Future<List<AdminEntity>> getAll();
}
