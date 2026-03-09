import '../../../core/network/query/query_builders.dart';
import '../../../core/utils/result.dart';
import 'pricing_entity.dart';
import 'pricing_repository.dart';

class CreatePricingRuleUseCase {
  const CreatePricingRuleUseCase(this._repository);
  final PricingRepository _repository;
  Future<Result<PricingRuleEntity>> call({required String name, required String type, required double value}) =>
      _repository.createRule(name: name, type: type, value: value);
}

class ListPricingRulesUseCase {
  const ListPricingRulesUseCase(this._repository);
  final PricingRepository _repository;
  Future<Result<PageResponse<PricingRuleEntity>>> call(PageRequest request) => _repository.listRules(request);
}

class CalculatePricingUseCase {
  const CalculatePricingUseCase(this._repository);
  final PricingRepository _repository;
  Future<Result<PricingCalculationEntity>> call({required String productId, required int quantity}) =>
      _repository.calculate(productId: productId, quantity: quantity);
}
