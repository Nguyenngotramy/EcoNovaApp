import 'package:flutter/material.dart';
import 'package:eco_nova_app/theme/app_theme.dart';

// Component: Order Status Badge
class OrderStatusBadge extends StatelessWidget {
  final String status; // 'pending', 'processing', 'completed', 'cancelled'

  const OrderStatusBadge({
    super.key,
    required this.status,
  });

  Color _getBackgroundColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange.withOpacity(0.2);
      case 'processing':
        return Colors.blue.withOpacity(0.2);
      case 'completed':
        return Colors.green.withOpacity(0.2);
      case 'cancelled':
        return Colors.red.withOpacity(0.2);
      default:
        return AppTheme.secondaryLight.withOpacity(0.2);
    }
  }

  Color _getTextColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange.shade700;
      case 'processing':
        return Colors.blue.shade700;
      case 'completed':
        return Colors.green.shade700;
      case 'cancelled':
        return Colors.red.shade700;
      default:
        return AppTheme.secondaryDark;
    }
  }

  String _getLabel() {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Chờ xác nhận';
      case 'processing':
        return 'Đang xử lý';
      case 'completed':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _getTextColor(),
          width: 1,
        ),
      ),
      child: Text(
        _getLabel(),
        style: AppTheme.caption.copyWith(
          color: _getTextColor(),
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}

// Component: Unread Badge (Red dot with count)
class UnreadCountBadge extends StatelessWidget {
  final int count;

  const UnreadCountBadge({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppTheme.errorColor,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(
        minWidth: 18,
        minHeight: 18,
      ),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Component: Seller Chat List Item
class SellerChatListItem extends StatelessWidget {
  final String customerName;
  final String customerImage;
  final String lastMessage;
  final String time;
  final String? orderStatus; // 'pending', 'processing', 'completed', 'cancelled'
  final int unreadCount;
  final VoidCallback? onTap;

  const SellerChatListItem({
    super.key,
    required this.customerName,
    required this.customerImage,
    required this.lastMessage,
    required this.time,
    this.orderStatus,
    this.unreadCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.borderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Avatar
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      customerImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.cardBackground,
                          child: const Icon(
                            Icons.person_outline,
                            color: AppTheme.textLight,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Online indicator (optional)
                // Positioned(
                //   right: 2,
                //   bottom: 2,
                //   child: Container(
                //     width: 12,
                //     height: 12,
                //     decoration: BoxDecoration(
                //       color: Colors.green,
                //       shape: BoxShape.circle,
                //       border: Border.all(color: Colors.white, width: 2),
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(width: 12),
            // Chat Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          customerName,
                          style: AppTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: unreadCount > 0 ? AppTheme.textPrimary : AppTheme.textSecondary,
                          ),
                           maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (orderStatus != null) ...[
                        OrderStatusBadge(status: orderStatus!),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: AppTheme.bodySmall.copyWith(
                            color: unreadCount > 0 ? AppTheme.textPrimary : AppTheme.textSecondary,
                            fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        UnreadCountBadge(count: unreadCount),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}