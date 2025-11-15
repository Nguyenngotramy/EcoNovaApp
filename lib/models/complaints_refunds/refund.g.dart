// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Refund _$RefundFromJson(Map<String, dynamic> json) => Refund(
  id: (json['id'] as num).toInt(),
  complaintId: (json['complaintId'] as num).toInt(),
  orderId: (json['orderId'] as num).toInt(),
  refundAmount: (json['refund_amount'] as num).toDouble(),
  refundMethod: $enumDecode(_$RefundMethodEnumMap, json['refundMethod']),
  status: $enumDecode(_$RefundStatusEnumMap, json['status']),
  transactionId: json['transaction_id'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
);

Map<String, dynamic> _$RefundToJson(Refund instance) => <String, dynamic>{
  'id': instance.id,
  'complaintId': instance.complaintId,
  'orderId': instance.orderId,
  'refund_amount': instance.refundAmount,
  'refundMethod': _$RefundMethodEnumMap[instance.refundMethod]!,
  'status': _$RefundStatusEnumMap[instance.status]!,
  'transaction_id': instance.transactionId,
  'createdAt': instance.createdAt.toIso8601String(),
  'completed_at': instance.completedAt?.toIso8601String(),
};

const _$RefundMethodEnumMap = {
  RefundMethod.wallet: 'wallet',
  RefundMethod.bank: 'bank',
  RefundMethod.originalPayment: 'originalPayment',
};

const _$RefundStatusEnumMap = {
  RefundStatus.pending: 'pending',
  RefundStatus.processing: 'processing',
  RefundStatus.completed: 'completed',
  RefundStatus.failed: 'failed',
};
