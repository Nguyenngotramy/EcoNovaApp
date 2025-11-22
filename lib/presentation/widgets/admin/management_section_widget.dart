// Updated ManagementSectionWidget with navigation onTap
import 'package:eco_nova_app/presentation/screens/admin/ai_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/banner_promotion_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/delivery_management_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/feedback_management_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/notification_management_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/order_management_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/product_monitoring_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/revenue_statistics_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/shipper_management_screen.dart';
import 'package:eco_nova_app/presentation/screens/admin/user_management_screen.dart';
import 'package:flutter/material.dart';
import 'management_card_widget.dart';
import 'section_header_widget.dart';

class ManagementSectionWidget extends StatelessWidget {
  const ManagementSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeaderWidget(title: 'Quản lý'),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                ManagementCardWidget(
                  title: 'Quản lý người dùng',
                  icon: Icons.people_outline,
                  color: const Color(0xFF043915),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserManagementScreen()),
                  ),
                ),
                ManagementCardWidget(
                  title: 'Quản lý shipper',
                  icon: Icons.delivery_dining_outlined,
                  color: const Color(0xFF4C763B),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShipperManagementScreen()),
                  ),
                ),
                ManagementCardWidget(
                  title: 'Giám sát sản phẩm',
                  icon: Icons.inventory_2_outlined,
                  color: const Color(0xFF043915),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductMonitoringScreen()),
                  ),
                ),
                ManagementCardWidget(
                  title: 'Quản lý đơn hàng',
                  icon: Icons.shopping_bag_outlined,
                  color: const Color(0xFFFF9800),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderManagementScreen()),
                  ),
                ),
                ManagementCardWidget(
                  title: 'Quản lý giao hàng',
                  icon: Icons.local_shipping_outlined,
                  color: const Color(0xFF043915),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DeliveryManagementScreen()),
                  ),
                ),
                ManagementCardWidget(
                  title: 'Thống kê doanh thu',
                  icon: Icons.bar_chart,
                  color: const Color(0xFF4C763B),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RevenueStatisticsScreen()),
                  ),
                ),
                ManagementCardWidget(
                  title: 'Quản lý AI',
                  icon: Icons.auto_awesome,
                  color: const Color(0xFF043915),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AIManagementScreen()), // Placeholder screen
                  ),
                ),
                ManagementCardWidget(
                  title: 'Phản hồi & khiếu nại',
                  icon: Icons.support_agent_outlined,
                  color: const Color(0xFFE53935),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedbackManagementScreen()),
                  ),
                ),
                ManagementCardWidget(
                  title: 'Banner & khuyến mãi',
                  icon: Icons.campaign_outlined,
                  color: const Color(0xFFFF9800),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BannerPromotionScreen()),
                  ),
                ),
                ManagementCardWidget(
                  title: 'Thông báo hệ thống',
                  icon: Icons.notifications_active_outlined,
                  color: const Color(0xFF043915),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationManagementScreen()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}