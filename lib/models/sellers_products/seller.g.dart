// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seller _$SellerFromJson(Map<String, dynamic> json) => Seller(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  farmName: json['farmName'] as String,
  businessLicense: json['businessLicense'] as String?,
  taxCode: json['taxCode'] as String?,
  description: json['description'] as String?,
  isVerified: json['isVerified'] as bool,
  ratingAvg: (json['ratingAvg'] as num).toDouble(),
  totalReviews: (json['totalReviews'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'farmName': instance.farmName,
  'businessLicense': instance.businessLicense,
  'taxCode': instance.taxCode,
  'description': instance.description,
  'isVerified': instance.isVerified,
  'ratingAvg': instance.ratingAvg,
  'totalReviews': instance.totalReviews,
  'createdAt': instance.createdAt.toIso8601String(),
};
