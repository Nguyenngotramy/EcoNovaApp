import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/presentation/widgets/seller/chat/seller_chat_detail.dart';
import 'package:flutter/material.dart';
import 'package:eco_nova_app/presentation/widgets/seller/chat/seller_chat_list_item.dart';
class SellerChatListScreen extends StatefulWidget {
  const SellerChatListScreen({super.key});

  @override
  State<SellerChatListScreen> createState() => _SellerChatListScreenState();
}

class _SellerChatListScreenState extends State<SellerChatListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mock data - Khách hàng của người bán
  final List<Map<String, dynamic>> _allChats = [
    {
      'id': '1',
      'customerName': 'Nguyễn Thị Lan Anh',
      'customerImage': 'assets/images/customer1.png',
      'lastMessage': 'Cà chua này ngọt không shop?',
      'time': '10:30',
      'orderStatus': 'pending',
      'unreadCount': 3,
    },
    {
      'id': '2',
      'customerName': 'Trần Văn Minh',
      'customerImage': 'assets/images/customer2.png',
      'lastMessage': 'Shop ơi đơn hàng của em đến đâu rồi ạ?',
      'time': '9:45',
      'orderStatus': 'processing',
      'unreadCount': 1,
    },
    {
      'id': '3',
      'customerName': 'Phạm Thu Hà',
      'customerImage': 'assets/images/customer3.png',
      'lastMessage': 'Cảm ơn shop nhé, hàng rất tươi!',
      'time': 'Hôm qua',
      'orderStatus': 'completed',
      'unreadCount': 0,
    },
    {
      'id': '4',
      'customerName': 'Lê Hoàng Nam',
      'customerImage': 'assets/images/customer4.png',
      'lastMessage': 'Shop có giảm giá không ạ?',
      'time': '2 giờ',
      'orderStatus': 'pending',
      'unreadCount': 2,
    },
    {
      'id': '5',
      'customerName': 'Võ Thị Mai',
      'customerImage': 'assets/images/customer5.png',
      'lastMessage': 'Em muốn đặt thêm 2kg nữa shop',
      'time': '1 giờ',
      'orderStatus': 'processing',
      'unreadCount': 5,
    },
    {
      'id': '6',
      'customerName': 'Đặng Văn Tùng',
      'customerImage': 'assets/images/customer6.png',
      'lastMessage': 'Dạ vâng, cảm ơn shop nhiều!',
      'time': '3 ngày',
      'orderStatus': 'completed',
      'unreadCount': 0,
    },
    {
      'id': '7',
      'customerName': 'Hoàng Thị Nga',
      'customerImage': 'assets/images/customer7.png',
      'lastMessage': 'Shop giao hàng lúc nào được ạ?',
      'time': '1 tuần',
      'orderStatus': 'cancelled',
      'unreadCount': 0,
    },
  ];

  List<Map<String, dynamic>> get _unreadChats => 
    _allChats.where((chat) => chat['unreadCount'] > 0).toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Tin nhắn khách hàng',
          style: AppTheme.heading3,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.primary),
            onPressed: () {
              // Handle search
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppTheme.primary),
            onPressed: () {
              _showFilterOptions(context);
            },
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.textLight,
          indicatorColor: AppTheme.primary,
          labelStyle: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: AppTheme.bodyMedium,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Tất cả'),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_allChats.length}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Chưa đọc'),
                  const SizedBox(width: 4),
                  if (_unreadChats.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_unreadChats.length}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab Tất cả
          _buildChatList(_allChats),
          // Tab Chưa đọc
          _buildChatList(_unreadChats),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle create new chat or view statistics
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.bar_chart_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildChatList(List<Map<String, dynamic>> chats) {
    if (chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: AppTheme.textLight.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có tin nhắn nào',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textLight,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return SellerChatListItem(
          customerName: chat['customerName'],
          customerImage: chat['customerImage'],
          lastMessage: chat['lastMessage'],
          time: chat['time'],
          orderStatus: chat['orderStatus'],
          unreadCount: chat['unreadCount'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SellerChatDetailScreen(
                  customerName: chat['customerName'],
                  customerImage: chat['customerImage'],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lọc theo trạng thái đơn hàng',
              style: AppTheme.heading3.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.orange),
              title: const Text('Chờ xác nhận'),
              onTap: () {
                Navigator.pop(context);
                // Filter by pending
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping_outlined, color: Colors.blue),
              title: const Text('Đang xử lý'),
              onTap: () {
                Navigator.pop(context);
                // Filter by processing
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline, color: Colors.green),
              title: const Text('Hoàn thành'),
              onTap: () {
                Navigator.pop(context);
                // Filter by completed
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel_outlined, color: Colors.red),
              title: const Text('Đã hủy'),
              onTap: () {
                Navigator.pop(context);
                // Filter by cancelled
              },
            ),
          ],
        ),
      ),
    );
  }
}