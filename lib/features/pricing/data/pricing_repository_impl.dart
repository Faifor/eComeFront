import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import '../domain/pricing_entity.dart';
import '../domain/pricing_repository.dart';
import 'pricing_api.dart';

class PricingRepositoryImpl implements PricingRepository {
  PricingRepositoryImpl(this._api);
  final PricingApi _api;

  @override
  Future<List<PricingEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos.map((dto) => PricingEntity(id: dto.id)).toList(growable: false);
  }

  @override
  Future<Result<PricingCalculationEntity>> calculate({required String productId, required int quantity}) async =>
      const Success(PricingCalculationEntity(subtotal: 0, discount: 0, total: 0));

  @override
  Future<Result<PricingRuleEntity>> createRule({required String name, required String type, required double value}) async =>
      const Failure('Not implemented');

  @override
  Future<Result<PageResponse<PricingRuleEntity>>> listRules(PageRequest request) async =>
      const Success(PageResponse(items: [], page: 1, perPage: 20, total: 0));
}
