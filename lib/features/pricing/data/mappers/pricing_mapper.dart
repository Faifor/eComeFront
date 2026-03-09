import '../../domain/pricing_entity.dart';
import '../models/pricing_models.dart';

extension PricingRuleDtoMapper on PricingRuleDto {
  PricingRuleEntity toEntity() => PricingRuleEntity(id: id, name: name, type: type, value: value);
}

extension PricingCalculationDtoMapper on PricingCalculateResponseDto {
  PricingCalculationEntity toEntity() =>
      PricingCalculationEntity(subtotal: subtotal, discount: discount, total: total);
}
