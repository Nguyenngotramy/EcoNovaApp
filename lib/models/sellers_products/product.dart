import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final int sellerId;
  final int categoryId;
  final String name;
  final String? description;
  final double price;
  final int stockQuantity;
  final String unit;
  final String? originProvince;
  final HarvestSeason harvestSeason;
  final String? storageInstruction;
  final ProductStatus status;
  final int viewCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.sellerId,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    required this.stockQuantity,
    required this.unit,
    this.originProvince,
    required this.harvestSeason,
    this.storageInstruction,
    required this.status,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}