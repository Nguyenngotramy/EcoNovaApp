// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentTracking _$ShipmentTrackingFromJson(Map<String, dynamic> json) =>
    ShipmentTracking(
      id: (json['id'] as num).toInt(),
      shipmentId: (json['shipmentId'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      status: $enumDecode(_$TrackingStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ShipmentTrackingToJson(ShipmentTracking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shipmentId': instance.shipmentId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': _$TrackingStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$TrackingStatusEnumMap = {
  TrackingStatus.pickedUp: 'pickedUp',
  TrackingStatus.inTransit: 'inTransit',
  TrackingStatus.nearDestination: 'nearDestination',
  TrackingStatus.delivered: 'delivered',
};
