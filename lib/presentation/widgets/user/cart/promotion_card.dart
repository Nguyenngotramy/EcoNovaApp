import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PromotionCard extends StatelessWidget {
  final double currentAmount;
  final double targetAmount;

  const PromotionCard({
    Key? key,
    required this.currentAmount,
    required this.targetAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = currentAmount / targetAmount;
    final remaining = targetAmount - currentAmount;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.local_shipping, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Ưu đãi vận chuyển',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Xem chi tiết',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Mua thêm ${remaining.toStringAsFixed(0)}₫ để nhận ưu đãi miễn phí vận chuyển cho đơn hàng từ 99k trở lên',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress > 1 ? 1 : progress,
              backgroundColor: Colors.white30,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${currentAmount.toStringAsFixed(0)}₫',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                '${targetAmount.toStringAsFixed(0)}₫',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}