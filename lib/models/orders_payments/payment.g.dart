// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
  id: (json['id'] as num).toInt(),
  orderId: (json['orderId'] as num).toInt(),
  paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
  status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
  amount: (json['amount'] as num).toDouble(),
  transactionId: json['transactionId'] as String?,
  paymentData: json['payment_data'] as Map<String, dynamic>?,
  paidAt: json['paidAt'] == null
      ? null
      : DateTime.parse(json['paidAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
  'status': _$PaymentStatusEnumMap[instance.status]!,
  'amount': instance.amount,
  'transactionId': instance.transactionId,
  'payment_data': instance.paymentData,
  'paidAt': instance.paidAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cod: 'cod',
  PaymentMethod.momo: 'momo',
  PaymentMethod.zaloPay: 'zaloPay',
  PaymentMethod.vnPay: 'vnPay',
  PaymentMethod.bankTransfer: 'bankTransfer',
  PaymentMethod.qrCode: 'qrCode',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
};
