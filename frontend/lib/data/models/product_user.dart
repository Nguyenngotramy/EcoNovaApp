class Product {
  final String id;
  final String name;
  final String description;
  final String detailedDescription;
  final Category category;
  final Seller seller;
  final double price;
  final double? originalPrice;
  final int discount;
  final int stock;
  final double weight;
  final String unit;
  final String? sku;
  final bool isOrganic;
  final bool isFeatured;
  final List<String> badges;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final int soldCount;
  final String status;
  final String? origin;
  final String? storageInstructions;
  final int? shelfLife;
  final NutritionInfo? nutritionInfo;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.detailedDescription,
    required this.category,
    required this.seller,
    required this.price,
    this.originalPrice,
    required this.discount,
    required this.stock,
    required this.weight,
    required this.unit,
    this.sku,
    required this.isOrganic,
    required this.isFeatured,
    required this.badges,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.soldCount,
    required this.status,
    this.origin,
    this.storageInstructions,
    this.shelfLife,
    this.nutritionInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
  List<String> parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) return value.map((e) => e.toString()).toList();
    return [];
  }

  double parseDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  return Product(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    detailedDescription: json['detailedDescription'] ?? '',
    category: json['category'] is Map<String, dynamic>
        ? Category.fromJson(json['category'])
        : Category(id: '', name: 'Chưa phân loại'),
    seller: json['seller'] is Map<String, dynamic>
        ? Seller.fromJson(json['seller'])
        : Seller(id: '', username: 'Shop', email: ''),
    price: parseDouble(json['salePrice'] ?? json['price']),
    
    originalPrice: json['originalPrice'] != null 
        ? parseDouble(json['originalPrice']) 
        : null,
    discount: json['discount'] ?? 0,
    stock: json['stock'] ?? 0,
    weight: parseDouble(json['weight']),
    unit: json['unit'] ?? '',
    sku: json['sku'],
    isOrganic: json['isOrganic'] ?? false,
    isFeatured: json['isFeatured'] ?? false,
    badges: parseStringList(json['badges']),
    images: parseStringList(json['images']),
    rating: parseDouble(json['rating']),
    
    reviewCount: json['reviewCount'] ?? 0,
    soldCount: json['soldCount'] ?? 0,
    status: json['status'] ?? 'active',
    origin: json['origin'],
    storageInstructions: json['storageInstructions'],
    shelfLife: json['shelfLife'],
    nutritionInfo: json['nutritionInfo'] is Map<String, dynamic>
        ? NutritionInfo.fromJson(json['nutritionInfo'])
        : null,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
        : DateTime.now(),
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now()
        : DateTime.now(),
  );
}

  // Getters tiện ích
  String get formattedPrice => '${price.toStringAsFixed(0)}đ';

  String? get discountText => discount > 0 ? '-$discount%' : null;

  List<String> get displayBadges {
    final List<String> result = [];
    if (isOrganic && !badges.contains('organic')) result.add('organic');
    if (discount > 0 && !badges.contains('sale')) result.add('sale');
    result.addAll(badges);
    return result;
  }

  String get sellerName => seller.username;
}

class Category {
  final String id;
  final String name;
  final String? description;
  final String? icon;

  Category({
    required this.id,
    required this.name,
    this.description,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Chưa phân loại',
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Seller {
  final String id;
  final String username;
  final String email;
  final String? phone;

  Seller({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['_id'] ?? '',
      username: json['username'] ?? 'Shop',
      email: json['email'] ?? '',
      phone: json['phone'],
    );
  }
}

class NutritionInfo {
  final String? calories;
  final String? protein;
  final String? carbs;
  final String? fat;
  final String? fiber;
  final String? vitamins;

  NutritionInfo({
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.fiber,
    this.vitamins,
  });

  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      calories: json['calories'],
      protein: json['protein'],
      carbs: json['carbs'],
      fat: json['fat'],
      fiber: json['fiber'],
      vitamins: json['vitamins'],
    );
  }
}
