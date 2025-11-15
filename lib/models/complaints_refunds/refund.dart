import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'refund.g.dart';

@JsonSerializable()
class Refund {
  final int id;
  final int complaintId;
  final int orderId;
  @JsonKey(name: 'refund_amount')
  final double refundAmount;
  final RefundMethod refundMethod;
  final RefundStatus status;
  @JsonKey(name: 'transaction_id')
  final String? transactionId;
  final DateTime createdAt;
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  Refund({
    required this.id,
    required this.complaintId,
    required this.orderId,
    required this.refundAmount,
    required this.refundMethod,
    required this.status,
    this.transactionId,
    required this.createdAt,
    this.completedAt,
  });

  factory Refund.fromJson(Map<String, dynamic> json) => _$RefundFromJson(json);
  Map<String, dynamic> toJson() => _$RefundToJson(this);
}