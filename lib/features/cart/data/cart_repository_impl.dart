import '../domain/cart_entity.dart';
import '../domain/cart_repository.dart';
import 'cart_api.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._api);

  final CartApi _api;

  @override
  Future<List<CartEntity>> getAll() async {
    final dtos = await _api.fetchAll();
    return dtos
        .map((dto) => CartEntity(id: dto.id))
        .toList(growable: false);
  }
}
