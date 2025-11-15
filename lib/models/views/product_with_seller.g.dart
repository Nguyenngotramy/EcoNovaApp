// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_with_seller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductWithSeller _$ProductWithSellerFromJson(Map<String, dynamic> json) =>
    ProductWithSeller(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      farmName: json['farmName'] as String,
      sellerRating: (json['seller_rating'] as num).toDouble(),
      sellerName: json['seller_name'] as String,
      sellerPhone: json['seller_phone'] as String,
      categoryName: json['category_name'] as String,
    );

Map<String, dynamic> _$ProductWithSellerToJson(ProductWithSeller instance) =>
    <String, dynamic>{
      'product': instance.product,
      'farmName': instance.farmName,
      'seller_rating': instance.sellerRating,
      'seller_name': instance.sellerName,
      'seller_phone': instance.sellerPhone,
      'category_name': instance.categoryName,
    };
