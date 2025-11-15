// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  addressLine: json['addressLine'] as String,
  ward: json['ward'] as String?,
  district: json['district'] as String?,
  city: json['city'] as String?,
  province: json['province'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isDefault: json['isDefault'] as bool,
  addressType: $enumDecode(_$AddressTypeEnumMap, json['addressType']),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'addressLine': instance.addressLine,
  'ward': instance.ward,
  'district': instance.district,
  'city': instance.city,
  'province': instance.province,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'isDefault': instance.isDefault,
  'addressType': _$AddressTypeEnumMap[instance.addressType]!,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$AddressTypeEnumMap = {
  AddressType.home: 'home',
  AddressType.office: 'office',
  AddressType.other: 'other',
};
