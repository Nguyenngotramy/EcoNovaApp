import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  final String orderNumber;
  final int buyerId;
  final int sellerId;
  final int shippingAddressId;
  final OrderStatus status;
  final double subtotal;
  final double shippingFee;
  final double discountAmount;
  final double totalAmount;
  final String? buyerNote;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.buyerId,
    required this.sellerId,
    required this.shippingAddressId,
    required this.status,
    required this.subtotal,
    required this.shippingFee,
    required this.discountAmount,
    required this.totalAmount,
    this.buyerNote,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}