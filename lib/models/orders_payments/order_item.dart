import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double unitPrice;
  final double subtotal;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}