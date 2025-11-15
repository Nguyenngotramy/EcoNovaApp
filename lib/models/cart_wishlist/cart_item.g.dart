// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  productId: (json['productId'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'productId': instance.productId,
  'quantity': instance.quantity,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
