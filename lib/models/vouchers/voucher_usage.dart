import 'package:json_annotation/json_annotation.dart';

part 'voucher_usage.g.dart';

@JsonSerializable()
class VoucherUsage {
  final int id;
  final int voucherId;
  final int userId;
  final int orderId;
  @JsonKey(name: 'used_at')
  final DateTime usedAt;

  VoucherUsage({
    required this.id,
    required this.voucherId,
    required this.userId,
    required this.orderId,
    required this.usedAt,
  });

  factory VoucherUsage.fromJson(Map<String, dynamic> json) => _$VoucherUsageFromJson(json);
  Map<String, dynamic> toJson() => _$VoucherUsageToJson(this);
}