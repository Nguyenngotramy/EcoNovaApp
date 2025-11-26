


import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../widgets/seller/home/category_card.dart';
import '../../widgets/seller/home/inventory_alert_card.dart';
import '../../widgets/seller/home/order_card.dart';
import '../../widgets/seller/home/quick_action_card.dart';
import '../../widgets/seller/home/section_header.dart';
import '../../widgets/seller/home/stat_card.dart';
import 'category_management_screen.dart';
import 'inventory_management_screen.dart';
import 'notification_screen.dart';
import 'products/add_product_screen.dart';

class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cardBackground,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fresh Farm', style: AppTheme.heading3),
            Text(
              'Người bán',
              style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppTheme.errorColor,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.trending_up,
                    iconColor: AppTheme.successColor,
                    value: '2.4M',
                    label: 'Doanh thu tháng',
                    change: '+12%',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: AppTheme.warningColor,
                    value: '45',
                    label: 'Đơn hàng mới',
                    change: '+8',
                  ),
                ),
              ],
            ),
            SectionHeader(title: 'Thao tác nhanh'),
            Row(
              children: [
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.add,
                    iconColor: AppTheme.successColor,
                    title: 'Thêm sản phẩm',
                    subtitle: 'Đăng sản phẩm mới',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddProductScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: QuickActionCard(
                    icon: Icons.inventory_2_outlined,
                    iconColor: AppTheme.warningColor,
                    title: 'Quản lý kho',
                    subtitle: 'Cập nhật tồn kho',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InventoryManagementScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SectionHeader(
              title: 'Đơn hàng mới',
              actionText: 'Xem tất cả',
              onActionTap: () {},
            ),
            OrderCard(
              imageUrl: 'https://via.placeholder.com/150',
              productName: 'Cà chua cherry',
              weight: '2kg',
              price: '80.000đ',
              status: 'Chờ xác nhận',
              statusColor: AppTheme.warningColor,
              deliveryTime: 'Đặt hàng: 10 phút trước',
              onConfirm: () {},
              onReject: () {},
            ),
            OrderCard(
              imageUrl: 'https://via.placeholder.com/150',
              productName: 'Xà lách xanh',
              weight: '1kg',
              price: '25.000đ',
              status: 'Đã xác nhận',
              statusColor: AppTheme.successColor,
              deliveryTime: 'Giao hàng: 2 giờ nữa',
              onConfirm: () {},
              onReject: () {},
            ),
            SectionHeader(
              title: 'Danh mục sản phẩm',
              actionText: 'Quản lý',
              onActionTap: () {
                // Navigate to CategoryManagementScreen for overall management
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryManagementScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 120,  // Chiều cao cố định cho các card để align đẹp
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CategoryCard(
                      id: 3,  // ID string
                      emoji: '🍎', 
                      title: 'Trái cây', 
                      count: 24, 
                      onTap: () {
                        // Navigate to CategoryManagementScreen with category data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryManagementScreen(
                              categoryId:3,
                              categoryTitle: 'Trái cây',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),  // Spacing giữa các card
                    CategoryCard(
                      id: 2,  // Fix: ID string
                      emoji: '🥬', 
                      title: 'Rau xanh', 
                      count: 18, 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryManagementScreen(
                              categoryId: 2,
                              categoryTitle: 'Rau xanh',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    CategoryCard(
                      id: 1,  // ID string
                      emoji: '🌾', 
                      title: 'Ngũ cốc', 
                      count: 12, 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryManagementScreen(
                              categoryId: 1,
                              categoryTitle: 'Ngũ cốc',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    // Thêm nhiều card nữa nếu cần, sẽ tự động scroll ngang
                    // Ví dụ: 
                    // CategoryCard(id: '4', emoji: '🥕', title: 'Rau củ', count: 15, onTap: () { /* navigate */ }),
                  ],
                ),
              ),
            ),
            SectionHeader(
              title: 'Cảnh báo tồn kho',
              actionText: '3 cảnh báo',
              onActionTap: () {},
            ),
            InventoryAlertCard(
              productName: 'Cà rốt baby',
              currentStock: '5kg',
              message: 'Còn lại: 5kg • Cần nhập thêm',
              alertColor: AppTheme.warningColor,
              onAction: () {},
            ),
          ],
        ),
      ),
    );
  }
}