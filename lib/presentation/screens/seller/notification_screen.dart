import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String selectedFilter = 'Tất cả';
  
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      type: NotificationType.order,
      title: 'Đơn hàng mới',
      message: 'Bạn có đơn hàng mới từ Nguyễn Văn A - 2kg Cà chua cherry',
      time: '10 phút trước',
      isRead: false,
      icon: Icons.shopping_cart,
      iconColor: AppTheme.warningColor,
    ),
    NotificationItem(
      id: '2',
      type: NotificationType.inventory,
      title: 'Cảnh báo tồn kho',
      message: 'Cà rốt baby sắp hết hàng. Còn lại: 5kg',
      time: '1 giờ trước',
      isRead: false,
      icon: Icons.inventory_2_outlined,
      iconColor: AppTheme.errorColor,
    ),
    NotificationItem(
      id: '3',
      type: NotificationType.order,
      title: 'Đơn hàng đã giao',
      message: 'Đơn hàng #12345 đã được giao thành công',
      time: '2 giờ trước',
      isRead: false,
      icon: Icons.check_circle_outline,
      iconColor: AppTheme.successColor,
    ),
    NotificationItem(
      id: '4',
      type: NotificationType.system,
      title: 'Khuyến mãi mới',
      message: 'Chương trình giảm giá 20% cho sản phẩm mới',
      time: '1 ngày trước',
      isRead: true,
      icon: Icons.local_offer_outlined,
      iconColor: AppTheme.primary,
    ),
    NotificationItem(
      id: '5',
      type: NotificationType.order,
      title: 'Đơn hàng bị hủy',
      message: 'Khách hàng đã hủy đơn hàng #12340',
      time: '2 ngày trước',
      isRead: true,
      icon: Icons.cancel_outlined,
      iconColor: AppTheme.errorColor,
    ),
    NotificationItem(
      id: '6',
      type: NotificationType.inventory,
      title: 'Nhập hàng thành công',
      message: 'Đã nhập 50kg Xà lách xanh vào kho',
      time: '3 ngày trước',
      isRead: true,
      icon: Icons.check_circle,
      iconColor: AppTheme.successColor,
    ),
  ];

  List<NotificationItem> get filteredNotifications {
    if (selectedFilter == 'Tất cả') return notifications;
    if (selectedFilter == 'Chưa đọc') {
      return notifications.where((n) => !n.isRead).toList();
    }
    return notifications.where((n) => n.type.toString().split('.').last == selectedFilter.toLowerCase()).toList();
  }

  void markAsRead(String id) {
    setState(() {
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index].isRead = true;
      }
    });
  }

  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  void deleteNotification(String id) {
    setState(() {
      notifications.removeWhere((n) => n.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: AppTheme.cardBackground,
      appBar: AppBar(
        title: const Text('Thông báo', style: AppTheme.heading3),
        actions: [
          TextButton(
            onPressed: unreadCount > 0 ? markAllAsRead : null,
            child: Text(
              'Đọc tất cả',
              style: AppTheme.bodySmall.copyWith(
                color: unreadCount > 0 ? AppTheme.primary : AppTheme.textLight,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppTheme.background,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Tất cả'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Chưa đọc', badgeCount: unreadCount),
                  const SizedBox(width: 8),
                  _buildFilterChip('Order'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Inventory'),
                  const SizedBox(width: 8),
                  _buildFilterChip('System'),
                ],
              ),
            ),
          ),
          Expanded(
            child: filteredNotifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Không có thông báo',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = filteredNotifications[index];
                      return _buildNotificationCard(notification);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {int? badgeCount}) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.borderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                color: isSelected ? AppTheme.background : AppTheme.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (badgeCount != null && badgeCount > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.background : AppTheme.errorColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badgeCount',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppTheme.primary : AppTheme.background,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        deleteNotification(notification.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã xóa thông báo'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.errorColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          if (!notification.isRead) {
            markAsRead(notification.id);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isRead ? AppTheme.background : AppTheme.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: notification.isRead ? AppTheme.borderColor : AppTheme.secondaryDark.withOpacity(0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: notification.iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  notification.icon,
                  color: notification.iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppTheme.errorColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: AppTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification.time,
                      style: AppTheme.caption.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum NotificationType {
  order,
  inventory,
  system,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final String time;
  bool isRead;
  final IconData icon;
  final Color iconColor;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.icon,
    required this.iconColor,
  });
}