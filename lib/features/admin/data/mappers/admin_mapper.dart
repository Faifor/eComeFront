import '../../domain/admin_entity.dart';
import '../models/admin_models.dart';

extension AdminItemDtoMapper on AdminItemDto {
  AdminItemEntity toEntity() => AdminItemEntity(id: id, name: name);
}

extension AdminReportDtoMapper on AdminReportDto {
  AdminReportEntity toEntity() => AdminReportEntity(key: key, value: value);
}
