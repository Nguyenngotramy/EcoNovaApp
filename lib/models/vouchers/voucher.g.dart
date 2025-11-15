// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voucher _$VoucherFromJson(Map<String, dynamic> json) => Voucher(
  id: (json['id'] as num).toInt(),
  code: json['code'] as String,
  type: $enumDecode(_$VoucherTypeEnumMap, json['type']),
  discountValue: (json['discount_value'] as num).toDouble(),
  minOrderValue: (json['min_order_value'] as num).toDouble(),
  maxDiscount: (json['max_discount'] as num?)?.toDouble(),
  usageLimit: (json['usage_limit'] as num?)?.toInt(),
  usedCount: (json['used_count'] as num).toInt(),
  validFrom: DateTime.parse(json['valid_from'] as String),
  validTo: DateTime.parse(json['valid_to'] as String),
  isActive: json['is_active'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'type': _$VoucherTypeEnumMap[instance.type]!,
  'discount_value': instance.discountValue,
  'min_order_value': instance.minOrderValue,
  'max_discount': instance.maxDiscount,
  'usage_limit': instance.usageLimit,
  'used_count': instance.usedCount,
  'valid_from': instance.validFrom.toIso8601String(),
  'valid_to': instance.validTo.toIso8601String(),
  'is_active': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$VoucherTypeEnumMap = {
  VoucherType.percentage: 'percentage',
  VoucherType.fixed: 'fixed',
  VoucherType.freeShipping: 'freeShipping',
};
