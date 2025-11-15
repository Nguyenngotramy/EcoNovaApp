import 'package:json_annotation/json_annotation.dart';

part 'shipper.g.dart';

@JsonSerializable()
class Shipper {
  final int id;
  final int userId;
  final String? vehicleType;
  final String? licensePlate;
  final String? idCardNumber;
  final bool isVerified;
  final bool isActive;
  final double ratingAvg;
  final int totalDeliveries;
  final int successDeliveries;
  final DateTime createdAt;

  Shipper({
    required this.id,
    required this.userId,
    this.vehicleType,
    this.licensePlate,
    this.idCardNumber,
    required this.isVerified,
    required this.isActive,
    required this.ratingAvg,
    required this.totalDeliveries,
    required this.successDeliveries,
    required this.createdAt,
  });

  factory Shipper.fromJson(Map<String, dynamic> json) => _$ShipperFromJson(json);
  Map<String, dynamic> toJson() => _$ShipperToJson(this);
}