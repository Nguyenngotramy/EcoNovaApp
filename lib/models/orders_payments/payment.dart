import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  final int id;
  final int orderId;
  final PaymentMethod paymentMethod;
  final PaymentStatus status;
  final double amount;
  final String? transactionId;
  @JsonKey(name: 'payment_data')
  final Map<String, dynamic>? paymentData; // JSON từ SQL
  final DateTime? paidAt;
  final DateTime createdAt;

  Payment({
    required this.id,
    required this.orderId,
    required this.paymentMethod,
    required this.status,
    required this.amount,
    this.transactionId,
    this.paymentData,
    this.paidAt,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}