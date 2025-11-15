import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final int id;
  final int userId;
  final int productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}