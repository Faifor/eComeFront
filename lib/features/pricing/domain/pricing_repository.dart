import 'pricing_entity.dart';

abstract interface class PricingRepository {
  Future<List<PricingEntity>> getAll();
}
