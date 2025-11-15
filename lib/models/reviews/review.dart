import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  final int id;
  final int productId;
  final int orderId;
  final int userId;
  @JsonKey(name: 'product_rating')
  final int? productRating;
  @JsonKey(name: 'seller_rating')
  final int? sellerRating;
  @JsonKey(name: 'shipper_rating')
  final int? shipperRating;
  final String? comment;
  @JsonKey(name: 'images_url')
  final List<String>? imagesUrl; // JSON array từ SQL
  @JsonKey(name: 'is_verified_purchase')
  final bool isVerifiedPurchase;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.userId,
    this.productRating,
    this.sellerRating,
    this.shipperRating,
    this.comment,
    this.imagesUrl,
    required this.isVerifiedPurchase,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}