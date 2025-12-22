import 'order_item_model.dart';

class Order {
  final String id;
  final String sellerName;
  final DateTime createdAt;
  final String status;
  final List<OrderItem> items;
  final double total;

  Order({
    required this.id,
    required this.sellerName,
    required this.createdAt,
    required this.status,
    required this.items,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
  return Order(
    id: json['_id'] ?? '',
    sellerName: json['sellerId']?['username'] ?? 'Unknown', // dùng ? để tránh null
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    status: json['status'] ?? 'pending',
    items: (json['products'] as List? ?? [])
        .map((e) => OrderItem.fromJson(e))
        .toList(),
    total: (json['total'] as num?)?.toDouble() ?? 0.0,
  );
}

}