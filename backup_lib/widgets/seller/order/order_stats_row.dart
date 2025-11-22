import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class OrderStatsRow extends StatelessWidget {
  final int totalOrders;
  final int pendingOrders;
  final int shippingOrders;
  final int completedToday;

  const OrderStatsRow({
    Key? key,
    required this.totalOrders,
    required this.pendingOrders,
    required this.shippingOrders,
    required this.completedToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Tổng đơn',
              totalOrders.toString(),
              Icons.receipt_long_outlined,
              AppTheme.primary,
            ),
          ),
          Container(width: 1, height: 40, color: AppTheme.borderColor),
          Expanded(
            child: _buildStatItem(
              'Chờ xử lý',
              pendingOrders.toString(),
              Icons.hourglass_empty,
              AppTheme.warningColor,
            ),
          ),
          Container(width: 1, height: 40, color: AppTheme.borderColor),
          Expanded(
            child: _buildStatItem(
              'Đang giao',
              shippingOrders.toString(),
              Icons.local_shipping_outlined,
              Colors.blue,
            ),
          ),
          Container(width: 1, height: 40, color: AppTheme.borderColor),
          Expanded(
            child: _buildStatItem(
              'Hoàn thành',
              completedToday.toString(),
              Icons.check_circle_outline,
              AppTheme.successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.heading3.copyWith(color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}