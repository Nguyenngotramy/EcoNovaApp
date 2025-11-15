import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'shipment_tracking.g.dart';

@JsonSerializable()
class ShipmentTracking {
  final int id;
  final int shipmentId;
  final double latitude;
  final double longitude;
  final TrackingStatus status;
  final DateTime createdAt;

  ShipmentTracking({
    required this.id,
    required this.shipmentId,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
  });

  factory ShipmentTracking.fromJson(Map<String, dynamic> json) => _$ShipmentTrackingFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentTrackingToJson(this);
}