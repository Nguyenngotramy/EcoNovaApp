import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'pre_order.g.dart';

@JsonSerializable()
class PreOrder {
  final int id;
  final int productId;
  final int userId;
  final int quantity;
  @JsonKey(name: 'deposit_amount')
  final double depositAmount;
  @JsonKey(name: 'expected_harvest')
  final DateTime expectedHarvest;
  final PreOrderStatus status;
  final DateTime createdAt;

  PreOrder({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.depositAmount,
    required this.expectedHarvest,
    required this.status,
    required this.createdAt,
  });

  factory PreOrder.fromJson(Map<String, dynamic> json) => _$PreOrderFromJson(json);
  Map<String, dynamic> toJson() => _$PreOrderToJson(this);
}