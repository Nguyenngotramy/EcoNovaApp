// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherUsage _$VoucherUsageFromJson(Map<String, dynamic> json) => VoucherUsage(
  id: (json['id'] as num).toInt(),
  voucherId: (json['voucherId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  orderId: (json['orderId'] as num).toInt(),
  usedAt: DateTime.parse(json['used_at'] as String),
);

Map<String, dynamic> _$VoucherUsageToJson(VoucherUsage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'voucherId': instance.voucherId,
      'userId': instance.userId,
      'orderId': instance.orderId,
      'used_at': instance.usedAt.toIso8601String(),
    };
