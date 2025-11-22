import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CartBottomSummary extends StatelessWidget {
  final int itemCount;
  final double subtotal;
  final double shippingFee;
  final double total;
  final VoidCallback onCheckout;

  const CartBottomSummary({
    Key? key,
    required this.itemCount,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.onCheckout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tạm tính ($itemCount sản phẩm)', style: AppTheme.bodyMedium),
              Text('${subtotal.toStringAsFixed(0)}₫', style: AppTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phí vận chuyển', style: AppTheme.bodyMedium),
              Text(
                shippingFee == 0 ? 'Miễn phí' : '${shippingFee.toStringAsFixed(0)}₫',
                style: AppTheme.bodyMedium.copyWith(color: AppTheme.successColor),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng cộng', style: AppTheme.heading3),
              Text(
                '${total.toStringAsFixed(0)}₫',
                style: AppTheme.heading2.copyWith(color: AppTheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onCheckout,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_bag_outlined, size: 20),
                  SizedBox(width: 8),
                  Text('Tiến hành đặt hàng'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}