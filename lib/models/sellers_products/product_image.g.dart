// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
  id: (json['id'] as num).toInt(),
  productId: (json['productId'] as num).toInt(),
  imageUrl: json['imageUrl'] as String?,
  videoUrl: json['videoUrl'] as String?,
  isPrimary: json['isPrimary'] as bool,
  sortOrder: (json['sortOrder'] as num).toInt(),
);

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'isPrimary': instance.isPrimary,
      'sortOrder': instance.sortOrder,
    };
