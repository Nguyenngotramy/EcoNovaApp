import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final int id;
  final int userId;
  final String addressLine;
  final String? ward;
  final String? district;
  final String? city;
  final String province;
  final double? latitude;
  final double? longitude;
  final bool isDefault;
  final AddressType addressType;
  final DateTime createdAt;

  Address({
    required this.id,
    required this.userId,
    required this.addressLine,
    this.ward,
    this.district,
    this.city,
    required this.province,
    this.latitude,
    this.longitude,
    required this.isDefault,
    required this.addressType,
    required this.createdAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}