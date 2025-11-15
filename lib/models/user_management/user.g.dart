// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  phone: json['phone'] as String,
  passwordHash: json['passwordHash'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  fullName: json['fullName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  isVerified: json['isVerified'] as bool,
  twoFactorEnabled: json['twoFactorEnabled'] as bool,
  twoFactorSecret: json['twoFactorSecret'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'phone': instance.phone,
  'passwordHash': instance.passwordHash,
  'role': _$UserRoleEnumMap[instance.role]!,
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'birthDate': instance.birthDate?.toIso8601String(),
  'gender': _$GenderEnumMap[instance.gender],
  'isVerified': instance.isVerified,
  'twoFactorEnabled': instance.twoFactorEnabled,
  'twoFactorSecret': instance.twoFactorSecret,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$UserRoleEnumMap = {
  UserRole.buyer: 'buyer',
  UserRole.seller: 'seller',
  UserRole.shipper: 'shipper',
  UserRole.admin: 'admin',
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};
