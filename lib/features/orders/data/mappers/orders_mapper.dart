import '../../domain/orders_entity.dart';
import '../models/orders_models.dart';

extension OrderDtoMapper on OrderDto {
  OrderEntity toEntity() => OrderEntity(id: id, status: status, total: total);
}
