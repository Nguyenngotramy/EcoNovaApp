class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String unit;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.unit,
    this.quantity = 1,
  });
}