import 'package:json_annotation/json_annotation.dart';

import '../../../../core/network/query/query_builders.dart';

@JsonSerializable()
class AdminItemUpsertRequestDto {
  const AdminItemUpsertRequestDto({required this.name, required this.payload});
  final String name;
  final Map<String, dynamic> payload;
  Map<String, dynamic> toJson() => {'name': name, 'payload': payload};
}

@JsonSerializable()
class AdminBulkRequestDto {
  const AdminBulkRequestDto({required this.ids, required this.action});
  final List<String> ids;
  final String action;
  Map<String, dynamic> toJson() => {'ids': ids, 'action': action};
}

@JsonSerializable()
class AdminImportRequestDto {
  const AdminImportRequestDto({required this.source, required this.format});
  final String source;
  final String format;
  Map<String, dynamic> toJson() => {'source': source, 'format': format};
}

@JsonSerializable()
class AdminListRequestDto {
  const AdminListRequestDto({this.pageRequest = const PageRequest()});
  final PageRequest pageRequest;
  Map<String, dynamic> toQuery() => pageRequest.toQuery();
}

@JsonSerializable()
class AdminItemDto {
  const AdminItemDto({required this.id, required this.name});
  final String id;
  final String name;
  factory AdminItemDto.fromJson(Map<String, dynamic> json) =>
      AdminItemDto(id: json['id'].toString(), name: json['name']?.toString() ?? '');
}

@JsonSerializable()
class AdminReportDto {
  const AdminReportDto({required this.key, required this.value});
  final String key;
  final num value;
  factory AdminReportDto.fromJson(Map<String, dynamic> json) => AdminReportDto(
    key: json['key']?.toString() ?? '',
    value: (json['value'] as num?) ?? 0,
  );
}
