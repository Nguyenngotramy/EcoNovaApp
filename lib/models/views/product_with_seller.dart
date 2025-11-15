import 'package:json_annotation/json_annotation.dart';
import '../sellers_products/product.dart';

part 'product_with_seller.g.dart';

@JsonSerializable()
class ProductWithSeller {
  final Product product;
  final String farmName;
  @JsonKey(name: 'seller_rating')
  final double sellerRating;
  @JsonKey(name: 'seller_name')
  final String sellerName;
  @JsonKey(name: 'seller_phone')
  final String sellerPhone;
  @JsonKey(name: 'category_name')
  final String categoryName;

  ProductWithSeller({
    required this.product,
    required this.farmName,
    required this.sellerRating,
    required this.sellerName,
    required this.sellerPhone,
    required this.categoryName,
  });

  factory ProductWithSeller.fromJson(Map<String, dynamic> json) => _$ProductWithSellerFromJson(json);
  Map<String, dynamic> toJson() => _$ProductWithSellerToJson(this);
}