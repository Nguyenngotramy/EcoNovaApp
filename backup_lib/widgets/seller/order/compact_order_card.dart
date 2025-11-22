import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CompactOrderCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String customerAvatar;
  final int itemCount;
  final String totalAmount;
  final String orderTime;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;
  final VoidCallback? onQuickAction;
  final String? quickActionLabel;

  const CompactOrderCard({
    Key? key,
    required this.orderId,
    required this.customerName,
    required this.customerAvatar,
    required this.itemCount,
    required this.totalAmount,
    required this.orderTime,
    required this.status,
    required this.statusColor,
    required this.onTap,
    this.onQuickAction,
    this.quickActionLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(customerAvatar),
                  backgroundColor: AppTheme.cardBackground,
                  child: customerAvatar.isEmpty 
                      ? const Icon(Icons.person, color: AppTheme.textLight)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('#$orderId', style: AppTheme.heading3),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              status,
                              style: AppTheme.caption.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customerName,
                        style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppTheme.textLight),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 16,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$itemCount sản phẩm',
                      style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
                Text(totalAmount, style: AppTheme.price),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppTheme.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      orderTime,
                      style: AppTheme.caption.copyWith(color: AppTheme.textLight),
                    ),
                  ],
                ),
                if (onQuickAction != null && quickActionLabel != null)
                  TextButton(
                    onPressed: onQuickAction,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(quickActionLabel!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}