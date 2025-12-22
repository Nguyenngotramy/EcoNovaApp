class OrderItem {
  final String id;
  final String name;
  final List<String> images;
  final double price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.images,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final product = json['productId'] ?? {};
    return OrderItem(
      id: product['_id'] ?? '',
      name: product['name'] ?? '',
      images: List<String>.from(product['images'] ?? []),
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
    );
  }
}
