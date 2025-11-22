import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String timeString;
  final bool isToday;
  final bool isUnread;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.timeString,
    required this.isToday,
    required this.isUnread,
    required this.icon,
  });
}

final mockNotifications = [
  NotificationItem(
    title: "Bạn có nhiệm vụ giao hàng mới",
    timeString: "Bây giờ",
    isToday: true,
    isUnread: true,
    icon: Icons.delivery_dining,
  ),
  NotificationItem(
    title: "Giao hàng không thành công. Vui lòng thử lại",
    timeString: "5 phút trước",
    isToday: true,
    isUnread: true,
    icon: Icons.error_outline,
  ),
  NotificationItem(
    title: "Đơn hàng đã bị hủy",
    timeString: "10 phút trước",
    isToday: true,
    isUnread: true,
    icon: Icons.close,
  ),
  NotificationItem(
    title: "Đơn hàng đang trên đường tới",
    timeString: "15 phút trước",
    isToday: true,
    isUnread: false,
    icon: Icons.local_shipping,
  ),
  NotificationItem(
    title: "Giao hàng thành công",
    timeString: "23 phút trước",
    isToday: true,
    isUnread: false,
    icon: Icons.check_circle_outline,
  ),

  // Yesterday
  NotificationItem(
    title: "Bạn có nhiệm vụ giao hàng mới",
    timeString: "1 ngày trước",
    isToday: false,
    isUnread: false,
    icon: Icons.delivery_dining,
  ),
];
// dữ liệu giả