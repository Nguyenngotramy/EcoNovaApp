import 'package:json_annotation/json_annotation.dart';

part 'seller.g.dart';

@JsonSerializable()
class Seller {
  final int id;
  final int userId;
  final String farmName;
  final String? businessLicense;
  final String? taxCode;
  final String? description;
  final bool isVerified;
  final double ratingAvg;
  final int totalReviews;
  final DateTime createdAt;

  Seller({
    required this.id,
    required this.userId,
    required this.farmName,
    this.businessLicense,
    this.taxCode,
    this.description,
    required this.isVerified,
    required this.ratingAvg,
    required this.totalReviews,
    required this.createdAt,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
  Map<String, dynamic> toJson() => _$SellerToJson(this);
}