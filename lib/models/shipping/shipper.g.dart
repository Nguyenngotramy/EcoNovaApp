// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shipper _$ShipperFromJson(Map<String, dynamic> json) => Shipper(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  vehicleType: json['vehicleType'] as String?,
  licensePlate: json['licensePlate'] as String?,
  idCardNumber: json['idCardNumber'] as String?,
  isVerified: json['isVerified'] as bool,
  isActive: json['isActive'] as bool,
  ratingAvg: (json['ratingAvg'] as num).toDouble(),
  totalDeliveries: (json['totalDeliveries'] as num).toInt(),
  successDeliveries: (json['successDeliveries'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ShipperToJson(Shipper instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'vehicleType': instance.vehicleType,
  'licensePlate': instance.licensePlate,
  'idCardNumber': instance.idCardNumber,
  'isVerified': instance.isVerified,
  'isActive': instance.isActive,
  'ratingAvg': instance.ratingAvg,
  'totalDeliveries': instance.totalDeliveries,
  'successDeliveries': instance.successDeliveries,
  'createdAt': instance.createdAt.toIso8601String(),
};
