import 'package:json_annotation/json_annotation.dart';
import '../enums.dart';

part 'voucher.g.dart';

@JsonSerializable()
class Voucher {
  final int id;
  final String code;
  final VoucherType type;
  @JsonKey(name: 'discount_value')
  final double discountValue;
  @JsonKey(name: 'min_order_value')
  final double minOrderValue;
  @JsonKey(name: 'max_discount')
  final double? maxDiscount;
  @JsonKey(name: 'usage_limit')
  final int? usageLimit;
  @JsonKey(name: 'used_count')
  final int usedCount;
  @JsonKey(name: 'valid_from')
  final DateTime validFrom;
  @JsonKey(name: 'valid_to')
  final DateTime validTo;
  @JsonKey(name: 'is_active')
  final bool isActive;
  final DateTime createdAt;

  Voucher({
    required this.id,
    required this.code,
    required this.type,
    required this.discountValue,
    required this.minOrderValue,
    this.maxDiscount,
    this.usageLimit,
    required this.usedCount,
    required this.validFrom,
    required this.validTo,
    required this.isActive,
    required this.createdAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => _$VoucherFromJson(json);
  Map<String, dynamic> toJson() => _$VoucherToJson(this);
}