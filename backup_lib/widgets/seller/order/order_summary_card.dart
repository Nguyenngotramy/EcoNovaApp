import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class OrderSummaryCard extends StatelessWidget {
  final String subtotal;
  final String shippingFee;
  final String? discount;
  final String total;

  const OrderSummaryCard({
    Key? key,
    required this.subtotal,
    required this.shippingFee,
    this.discount,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          _buildRow('Tạm tính', subtotal),
          const SizedBox(height: 8),
          _buildRow('Phí vận chuyển', shippingFee),
          if (discount != null) ...[
            const SizedBox(height: 8),
            _buildRow('Giảm giá', discount!, isDiscount: true),
          ],
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng cộng', style: AppTheme.heading3),
              Text(
                total,
                style: AppTheme.heading2.copyWith(color: AppTheme.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
        ),
        Text(
          isDiscount ? '-$value' : value,
          style: AppTheme.bodyMedium.copyWith(
            color: isDiscount ? AppTheme.errorColor : AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}