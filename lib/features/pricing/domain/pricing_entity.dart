class PricingRuleEntity {
  const PricingRuleEntity({required this.id, required this.name, required this.type, required this.value});
  final String id;
  final String name;
  final String type;
  final double value;
}

class PricingCalculationEntity {
  const PricingCalculationEntity({required this.subtotal, required this.discount, required this.total});
  final double subtotal;
  final double discount;
  final double total;
}

class PricingEntity {
  const PricingEntity({required this.id});
  final String id;
}
