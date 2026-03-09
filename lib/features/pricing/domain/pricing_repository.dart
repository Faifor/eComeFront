import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import 'pricing_entity.dart';

abstract interface class PricingRepository {
  Future<Result<PricingRuleEntity>> createRule({required String name, required String type, required double value});
  Future<Result<PageResponse<PricingRuleEntity>>> listRules(PageRequest request);
  Future<Result<PricingCalculationEntity>> calculate({required String productId, required int quantity});

  Future<List<PricingEntity>> getAll();
}
