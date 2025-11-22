class Product {
  final String imageUrl;
  final String name;
  final double quantity;
  final double price;
  int count;

  Product({
    required this.imageUrl,
    required this.name,
    required this.quantity,
    required this.price,
    this.count = 1, // Mặc định số lượng là 1
  });

}