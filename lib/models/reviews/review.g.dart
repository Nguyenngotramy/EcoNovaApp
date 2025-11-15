// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  id: (json['id'] as num).toInt(),
  productId: (json['productId'] as num).toInt(),
  orderId: (json['orderId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  productRating: (json['product_rating'] as num?)?.toInt(),
  sellerRating: (json['seller_rating'] as num?)?.toInt(),
  shipperRating: (json['shipper_rating'] as num?)?.toInt(),
  comment: json['comment'] as String?,
  imagesUrl: (json['images_url'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  isVerifiedPurchase: json['is_verified_purchase'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'orderId': instance.orderId,
  'userId': instance.userId,
  'product_rating': instance.productRating,
  'seller_rating': instance.sellerRating,
  'shipper_rating': instance.shipperRating,
  'comment': instance.comment,
  'images_url': instance.imagesUrl,
  'is_verified_purchase': instance.isVerifiedPurchase,
  'createdAt': instance.createdAt.toIso8601String(),
};
