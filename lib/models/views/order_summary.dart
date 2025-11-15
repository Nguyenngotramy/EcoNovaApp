import 'package:json_annotation/json_annotation.dart';
import '../orders_payments/order.dart';
import '../../models/enums.dart'; // Import enums

part 'order_summary.g.dart';

@JsonSerializable()
class OrderSummary {
  final Order order;
  @JsonKey(name: 'buyer_name')
  final String buyerName;
  @JsonKey(name: 'buyer_email')
  final String buyerEmail;
  @JsonKey(name: 'seller_farm')
  final String sellerFarm;
  @JsonKey(name: 'total_items')
  final int totalItems;
  @JsonKey(name: 'payment_status')
  final PaymentStatus? paymentStatus;
  @JsonKey(name: 'shipping_status')
  final ShipmentStatus? shippingStatus;

  OrderSummary({
    required this.order,
    required this.buyerName,
    required this.buyerEmail,
    required this.sellerFarm,
    required this.totalItems,
    this.paymentStatus,
    this.shippingStatus,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) => _$OrderSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$OrderSummaryToJson(this);
}