
import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/presentation/screens/user/cart_screen.dart';
import 'package:eco_nova_app/presentation/widgets/user/cart/badge_icon_button.dart';
import 'package:eco_nova_app/presentation/widgets/user/component/ai_button.dart';
import 'package:eco_nova_app/presentation/widgets/user/myorders/order_card.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<String> _tabs = ['Tất cả', 'Chờ xác nhận', 'Giao hàng', 'Hoàn thành'];

  // Mock data
  final List<Map<String, dynamic>> _mockOrders = [
    {
      'id': '1',
      'orderTitle': 'Nông trại vui vẻ',
      'orderCode': 'M01NTVV',
      'orderDate': '4/11/2025',
      'status': 'completed',
      'totalAmount': 115000.0,
      'products': [
        {
          'name': 'Nông trại vui vẻ',
          'imageUrl': 'assets/images/product1.png',
          'shopName': 'Đình Vương Tạ',
          'price': 25000.0,
          'quantity': 1,
        },
        {
          'name': 'Cà chua bi organic',
          'imageUrl': 'assets/images/product2.png',
          'shopName': 'Đình Vương Tạ',
          'price': 45000.0,
          'quantity': 2,
        },
      ],
    },
    {
      'id': '2',
      'orderTitle': 'Nông trại vui vẻ',
      'orderCode': 'M01NTVV',
      'orderDate': '4/11/2025',
      'status': 'pending',
      'totalAmount': 115000.0,
      'products': [
        {
          'name': 'Nông trại vui vẻ',
          'imageUrl': 'assets/images/product1.png',
          'shopName': 'Đình Vương Tạ',
          'price': 25000.0,
          'quantity': 1,
        },
        {
          'name': 'Cà chua bi organic',
          'imageUrl': 'assets/images/product2.png',
          'shopName': 'Đình Vương Tạ',
          'price': 45000.0,
          'quantity': 2,
        },
      ],
    },
    {
      'id': '3',
      'orderTitle': 'Nông trại vui vẻ',
      'orderCode': 'M01NTVV',
      'orderDate': '3/11/2025',
      'status': 'waiting',
      'totalAmount': 115000.0,
      'products': [
        {
          'name': 'Nông trại vui vẻ',
          'imageUrl': 'assets/images/product1.png',
          'shopName': 'Đình Vương Tạ',
          'price': 25000.0,
          'quantity': 1,
        },
        {
          'name': 'Cà chua bi organic',
          'imageUrl': 'assets/images/product2.png',
          'shopName': 'Đình Vương Tạ',
          'price': 45000.0,
          'quantity': 2,
        },
      ],
    },
    {
      'id': '4',
      'orderTitle': 'Rau củ hữu cơ',
      'orderCode': 'M02RCHC',
      'orderDate': '2/11/2025',
      'status': 'cancelled',
      'totalAmount': 95000.0,
      'products': [
        {
          'name': 'Rau cải xanh organic',
          'imageUrl': 'assets/images/product3.png',
          'shopName': 'Fresh Farm',
          'price': 30000.0,
          'quantity': 2,
        },
        {
          'name': 'Cà rót tím',
          'imageUrl': 'assets/images/product4.png',
          'shopName': 'Fresh Farm',
          'price': 35000.0,
          'quantity': 1,
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredOrders(int index) {
    switch (index) {
      case 0: // Tất cả
        return _mockOrders;
      case 1: // Chờ xác nhận
        return _mockOrders.where((order) => order['status'] == 'waiting').toList();
      case 2: // Giao hàng
        return _mockOrders.where((order) => order['status'] == 'pending').toList();
      case 3: // Hoàn thành
        return _mockOrders.where((order) => order['status'] == 'completed').toList();
      default:
        return _mockOrders;
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Đơn hàng của tôi',
          style: AppTheme.heading3,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.primary),
            onPressed: () {
              // Handle search
            },
          ),
          Stack(
            children: [
            BadgeIconButton(
            icon: Icons.shopping_cart_outlined,
            badgeCount: 1,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
            ],
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              labelColor: AppTheme.primary,
              unselectedLabelColor: AppTheme.textLight,
              labelStyle: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTheme.bodyMedium,
              indicatorColor: AppTheme.primary,
              indicatorWeight: 3,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(_tabs.length, (index) {
          final filteredOrders = _getFilteredOrders(index);
          
          if (filteredOrders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có đơn hàng nào',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              return OrderCard(
                orderTitle: order['orderTitle'],
                orderCode: order['orderCode'],
                orderDate: order['orderDate'],
                status: order['status'],
                products: List<Map<String, dynamic>>.from(order['products']),
                totalAmount: order['totalAmount'],
                onPrimaryAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Xử lý action chính cho đơn ${order['orderCode']}'),
                      backgroundColor: AppTheme.primary,
                    ),
                  );
                },
                onSecondaryAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Xử lý action phụ cho đơn ${order['orderCode']}'),
                      backgroundColor: AppTheme.textSecondary,
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
      floatingActionButton: AI_Button(),
    );
  }
}