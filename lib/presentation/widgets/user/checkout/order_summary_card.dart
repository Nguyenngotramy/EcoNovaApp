import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  final double subtotal;
  final double shippingFee;
  final String paymentMethod;
  final VoidCallback onSelectPromo;

  const OrderSummaryCard({
    Key? key,
    required this.subtotal,
    required this.shippingFee,
    required this.paymentMethod,
    required this.onSelectPromo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Chi tiết đơn hàng', style: AppTheme.bodyMedium),
              Text('${subtotal.toStringAsFixed(0)}₫', style: AppTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phí giao hàng', style: AppTheme.bodyMedium),
              Text(
                shippingFee == 0 ? 'Miễn phí' : '${shippingFee.toStringAsFixed(0)}₫',
                style: const TextStyle(color: AppTheme.successColor, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Mã giảm giá', style: AppTheme.bodyMedium),
              GestureDetector(
                onTap: onSelectPromo,
                child: const Text(
                  'Chọn mã',
                  style: TextStyle(color: AppTheme.primary, fontSize: 14),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phương thức thanh toán', style: AppTheme.bodyMedium),
              Text(
                paymentMethod,
                style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}