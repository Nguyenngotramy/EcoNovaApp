import 'package:json_annotation/json_annotation.dart';

part 'product_image.g.dart';

@JsonSerializable()
class ProductImage {
  final int id;
  final int productId;
  final String? imageUrl;
  final String? videoUrl;
  final bool isPrimary;
  final int sortOrder;

  ProductImage({
    required this.id,
    required this.productId,
    this.imageUrl,
    this.videoUrl,
    required this.isPrimary,
    required this.sortOrder,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}