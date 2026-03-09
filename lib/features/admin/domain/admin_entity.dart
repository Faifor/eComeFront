class AdminItemEntity {
  const AdminItemEntity({required this.id, required this.name});
  final String id;
  final String name;
}

class AdminReportEntity {
  const AdminReportEntity({required this.key, required this.value});
  final String key;
  final num value;
}

class AdminEntity {
  const AdminEntity({required this.id});
  final String id;
}
