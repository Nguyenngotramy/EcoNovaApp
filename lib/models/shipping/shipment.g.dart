// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shipment _$ShipmentFromJson(Map<String, dynamic> json) => Shipment(
  id: (json['id'] as num).toInt(),
  orderId: (json['orderId'] as num).toInt(),
  shipperId: (json['shipperId'] as num?)?.toInt(),
  status: $enumDecode(_$ShipmentStatusEnumMap, json['status']),
  shippingFee: (json['shippingFee'] as num).toDouble(),
  pickupAddress: json['pickupAddress'] as String,
  deliveryAddress: json['deliveryAddress'] as String,
  pickupLat: (json['pickup_lat'] as num?)?.toDouble(),
  pickupLng: (json['pickup_lng'] as num?)?.toDouble(),
  deliveryLat: (json['delivery_lat'] as num?)?.toDouble(),
  deliveryLng: (json['delivery_lng'] as num?)?.toDouble(),
  pickupTime: json['pickup_time'] == null
      ? null
      : DateTime.parse(json['pickup_time'] as String),
  estimatedDelivery: json['estimated_delivery'] == null
      ? null
      : DateTime.parse(json['estimated_delivery'] as String),
  deliveredAt: json['delivered_at'] == null
      ? null
      : DateTime.parse(json['delivered_at'] as String),
  deliveryProofUrl: json['delivery_proof_url'] as String?,
  deliveryOtp: json['delivery_otp'] as String?,
  failureReason: json['failure_reason'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ShipmentToJson(Shipment instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'shipperId': instance.shipperId,
  'status': _$ShipmentStatusEnumMap[instance.status]!,
  'shippingFee': instance.shippingFee,
  'pickupAddress': instance.pickupAddress,
  'deliveryAddress': instance.deliveryAddress,
  'pickup_lat': instance.pickupLat,
  'pickup_lng': instance.pickupLng,
  'delivery_lat': instance.deliveryLat,
  'delivery_lng': instance.deliveryLng,
  'pickup_time': instance.pickupTime?.toIso8601String(),
  'estimated_delivery': instance.estimatedDelivery?.toIso8601String(),
  'delivered_at': instance.deliveredAt?.toIso8601String(),
  'delivery_proof_url': instance.deliveryProofUrl,
  'delivery_otp': instance.deliveryOtp,
  'failure_reason': instance.failureReason,
  'createdAt': instance.createdAt.toIso8601String(),
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
