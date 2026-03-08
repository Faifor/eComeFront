import '../domain/pricing_entity.dart';
import '../domain/pricing_repository.dart';
import 'pricing_api.dart';

class PricingRepositoryImpl implements PricingRepository {
  PricingRepositoryImpl(this._api);

  final PricingApi _api;

  @override
  Future<List<PricingEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos
        .map((dto) => PricingEntity(id: dto.id))
        .toList(growable: false);
  }
}
