import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'shipment.g.dart';

@JsonSerializable()
class Shipment {
  final int id;
  final int orderId;
  final int? shipperId;
  final ShipmentStatus status;
  final double shippingFee;
  final String pickupAddress;
  final String deliveryAddress;
  @JsonKey(name: 'pickup_lat')
  final double? pickupLat;
  @JsonKey(name: 'pickup_lng')
  final double? pickupLng;
  @JsonKey(name: 'delivery_lat')
  final double? deliveryLat;
  @JsonKey(name: 'delivery_lng')
  final double? deliveryLng;
  @JsonKey(name: 'pickup_time')
  final DateTime? pickupTime;
  @JsonKey(name: 'estimated_delivery')
  final DateTime? estimatedDelivery;
  @JsonKey(name: 'delivered_at')
  final DateTime? deliveredAt;
  @JsonKey(name: 'delivery_proof_url')
  final String? deliveryProofUrl;
  @JsonKey(name: 'delivery_otp')
  final String? deliveryOtp;
  @JsonKey(name: 'failure_reason')
  final String? failureReason;
  final DateTime createdAt;

  Shipment({
    required this.id,
    required this.orderId,
    this.shipperId,
    required this.status,
    required this.shippingFee,
    required this.pickupAddress,
    required this.deliveryAddress,
    this.pickupLat,
    this.pickupLng,
    this.deliveryLat,
    this.deliveryLng,
    this.pickupTime,
    this.estimatedDelivery,
    this.deliveredAt,
    this.deliveryProofUrl,
    this.deliveryOtp,
    this.failureReason,
    required this.createdAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => _$ShipmentFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentToJson(this);
}