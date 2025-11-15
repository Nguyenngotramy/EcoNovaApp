// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSummary _$OrderSummaryFromJson(Map<String, dynamic> json) => OrderSummary(
  order: Order.fromJson(json['order'] as Map<String, dynamic>),
  buyerName: json['buyer_name'] as String,
  buyerEmail: json['buyer_email'] as String,
  sellerFarm: json['seller_farm'] as String,
  totalItems: (json['total_items'] as num).toInt(),
  paymentStatus: $enumDecodeNullable(
    _$PaymentStatusEnumMap,
    json['payment_status'],
  ),
  shippingStatus: $enumDecodeNullable(
    _$ShipmentStatusEnumMap,
    json['shipping_status'],
  ),
);

Map<String, dynamic> _$OrderSummaryToJson(OrderSummary instance) =>
    <String, dynamic>{
      'order': instance.order,
      'buyer_name': instance.buyerName,
      'buyer_email': instance.buyerEmail,
      'seller_farm': instance.sellerFarm,
      'total_items': instance.totalItems,
      'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus],
      'shipping_status': _$ShipmentStatusEnumMap[instance.shippingStatus],
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
};

const _$ShipmentStatusEnumMap = {
  ShipmentStatus.pending: 'pending',
  ShipmentStatus.accepted: 'accepted',
  ShipmentStatus.pickedUp: 'pickedUp',
  ShipmentStatus.inTransit: 'inTransit',
  ShipmentStatus.delivered: 'delivered',
  ShipmentStatus.failed: 'failed',
  ShipmentStatus.returned: 'returned',
};
