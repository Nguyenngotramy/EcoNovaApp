import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'order_status_history.g.dart';

@JsonSerializable()
class OrderStatusHistory {
  final int id;
  final int orderId;
  final OrderStatus status;
  final String? note;
  final int? updatedBy;
  final DateTime createdAt;

  OrderStatusHistory({
    required this.id,
    required this.orderId,
    required this.status,
    this.note,
    this.updatedBy,
    required this.createdAt,
  });

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) => _$OrderStatusHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusHistoryToJson(this);
}