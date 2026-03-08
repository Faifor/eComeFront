import '../domain/admin_entity.dart';
import '../domain/admin_repository.dart';
import 'admin_api.dart';

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl(this._api);

  final AdminApi _api;

  @override
  Future<List<AdminEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos
        .map((dto) => AdminEntity(id: dto.id))
        .toList(growable: false);
  }
}
