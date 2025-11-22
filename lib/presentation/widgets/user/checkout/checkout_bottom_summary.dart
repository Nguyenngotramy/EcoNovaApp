import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CheckoutBottomSummary extends StatelessWidget {
  final double total;
  final VoidCallback onCheckout;

  const CheckoutBottomSummary({
    Key? key,
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
              const Text('Tổng cộng', style: AppTheme.heading3),
              Text(
                '${total.toStringAsFixed(0)}₫',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onCheckout,
              child: const Text('Thanh toán'),
            ),
          ),
        ],
      ),
    );
  }
}