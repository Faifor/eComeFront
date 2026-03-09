class OrderEntity {
  const OrderEntity({required this.id, required this.status, required this.total});
  final String id;
  final String status;
  final double total;
}

class OrdersEntity {
  const OrdersEntity({required this.id});
  final String id;
}
