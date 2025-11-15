// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreOrder _$PreOrderFromJson(Map<String, dynamic> json) => PreOrder(
  id: (json['id'] as num).toInt(),
  productId: (json['productId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  depositAmount: (json['deposit_amount'] as num).toDouble(),
  expectedHarvest: DateTime.parse(json['expected_harvest'] as String),
  status: $enumDecode(_$PreOrderStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PreOrderToJson(PreOrder instance) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'userId': instance.userId,
  'quantity': instance.quantity,
  'deposit_amount': instance.depositAmount,
  'expected_harvest': instance.expectedHarvest.toIso8601String(),
  'status': _$PreOrderStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$PreOrderStatusEnumMap = {
  PreOrderStatus.pending: 'pending',
  PreOrderStatus.confirmed: 'confirmed',
  PreOrderStatus.ready: 'ready',
  PreOrderStatus.completed: 'completed',
  PreOrderStatus.cancelled: 'cancelled',
};
