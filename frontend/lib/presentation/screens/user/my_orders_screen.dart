import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/order_model.dart';
import '../../../services/order_service.dart';
import '../../widgets/user/cart/badge_icon_button.dart';
import '../../widgets/user/myorders/order_card.dart';
import 'cart_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
    
  final List<String> _tabs = [
    'Tất cả',
    'Chờ xác nhận',
    'Giao hàng',
    'Hoàn thành'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  List<Order> _filterOrders(List<Order> orders, int index) {
    switch (index) {
      case 1:
        return orders.where((o) => o.status == 'waiting').toList();
      case 2:
        return orders.where((o) => o.status == 'pending').toList();
      case 3:
        return orders.where((o) => o.status == 'completed').toList();
      default:
        return orders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Đơn hàng của tôi', style: AppTheme.heading3),
        actions: [
          BadgeIconButton(
            icon: Icons.shopping_cart_outlined,
            badgeCount: 1,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.textLight,
          indicatorColor: AppTheme.primary,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      
      body: FutureBuilder<List<Order>>(
        future: OrderService.getOrders(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Lỗi tải đơn hàng: ${snapshot.error} ',
                style: AppTheme.bodyMedium,
              ),
            );
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return const Center(
              child: Text('Bạn chưa có đơn hàng nào'),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: List.generate(_tabs.length, (tabIndex) {
              final filteredOrders = _filterOrders(orders, tabIndex);

              if (filteredOrders.isEmpty) {
                return const Center(
                  child: Text('Không có đơn hàng'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];

                  return OrderCard(
                    orderTitle: order.sellerName,
                    orderCode: order.id,
                    orderDate:
                        '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
                    status: order.status,
                    totalAmount: order.total,
                    products: order.items.map((item) {
                      return {
                        'name': item.name,
                        'imageUrl': item.images.isNotEmpty ? item.images[0] : '',
                        'price': item.price,
                        'quantity': item.quantity,
                      };
                    }).toList(),
                    onPrimaryAction: () {},
                    onSecondaryAction: () {},
                  );
                },
              );
            }),
          );
        },
      ),
      
    );
  }
}
