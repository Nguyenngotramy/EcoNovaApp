// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: (json['id'] as num).toInt(),
  orderNumber: json['orderNumber'] as String,
  buyerId: (json['buyerId'] as num).toInt(),
  sellerId: (json['sellerId'] as num).toInt(),
  shippingAddressId: (json['shippingAddressId'] as num).toInt(),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  subtotal: (json['subtotal'] as num).toDouble(),
  shippingFee: (json['shippingFee'] as num).toDouble(),
  discountAmount: (json['discountAmount'] as num).toDouble(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  buyerNote: json['buyerNote'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'orderNumber': instance.orderNumber,
  'buyerId': instance.buyerId,
  'sellerId': instance.sellerId,
  'shippingAddressId': instance.shippingAddressId,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'subtotal': instance.subtotal,
  'shippingFee': instance.shippingFee,
  'discountAmount': instance.discountAmount,
  'totalAmount': instance.totalAmount,
  'buyerNote': instance.buyerNote,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.confirmed: 'confirmed',
  OrderStatus.preparing: 'preparing',
  OrderStatus.shipping: 'shipping',
  OrderStatus.delivered: 'delivered',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
  OrderStatus.refunded: 'refunded',
};
