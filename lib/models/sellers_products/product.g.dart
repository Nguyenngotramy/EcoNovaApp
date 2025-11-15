// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: (json['id'] as num).toInt(),
  sellerId: (json['sellerId'] as num).toInt(),
  categoryId: (json['categoryId'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  stockQuantity: (json['stockQuantity'] as num).toInt(),
  unit: json['unit'] as String,
  originProvince: json['originProvince'] as String?,
  harvestSeason: $enumDecode(_$HarvestSeasonEnumMap, json['harvestSeason']),
  storageInstruction: json['storageInstruction'] as String?,
  status: $enumDecode(_$ProductStatusEnumMap, json['status']),
  viewCount: (json['viewCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'sellerId': instance.sellerId,
  'categoryId': instance.categoryId,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'stockQuantity': instance.stockQuantity,
  'unit': instance.unit,
  'originProvince': instance.originProvince,
  'harvestSeason': _$HarvestSeasonEnumMap[instance.harvestSeason]!,
  'storageInstruction': instance.storageInstruction,
  'status': _$ProductStatusEnumMap[instance.status]!,
  'viewCount': instance.viewCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$HarvestSeasonEnumMap = {
  HarvestSeason.spring: 'spring',
  HarvestSeason.summer: 'summer',
  HarvestSeason.fall: 'fall',
  HarvestSeason.winter: 'winter',
  HarvestSeason.yearRound: 'yearRound',
};

const _$ProductStatusEnumMap = {
  ProductStatus.pending: 'pending',
  ProductStatus.active: 'active',
  ProductStatus.inactive: 'inactive',
  ProductStatus.rejected: 'rejected',
};
