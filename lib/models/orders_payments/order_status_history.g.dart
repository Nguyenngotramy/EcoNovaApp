// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusHistory _$OrderStatusHistoryFromJson(Map<String, dynamic> json) =>
    OrderStatusHistory(
      id: (json['id'] as num).toInt(),
      orderId: (json['orderId'] as num).toInt(),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      note: json['note'] as String?,
      updatedBy: (json['updatedBy'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OrderStatusHistoryToJson(OrderStatusHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'note': instance.note,
      'updatedBy': instance.updatedBy,
      'createdAt': instance.createdAt.toIso8601String(),
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
