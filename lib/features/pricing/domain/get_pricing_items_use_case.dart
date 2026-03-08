import 'pricing_entity.dart';
import 'pricing_repository.dart';

class GetPricingItemsUseCase {
  GetPricingItemsUseCase(this._repository);

  final PricingRepository _repository;

  Future<List<PricingEntity>> call() {
    return _repository.getAll();
  }
}
