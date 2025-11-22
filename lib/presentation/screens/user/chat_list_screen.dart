
import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/presentation/screens/user/cart_screen.dart';
import 'package:eco_nova_app/presentation/widgets/user/cart/badge_icon_button.dart';
import 'package:eco_nova_app/presentation/widgets/user/chat/chat_list_item.dart';
import 'package:eco_nova_app/presentation/widgets/user/chat/chatdetail.dart';
import 'package:eco_nova_app/presentation/widgets/user/component/ai_button.dart';
import 'package:flutter/material.dart';
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // Mock data
  final List<Map<String, dynamic>> _mockChats = [
    {
      'id': '1',
      'shopName': 'Nông trại vui vẻ',
      'shopImage': 'assets/images/shop1.png',
      'lastMessage': 'Shop đã gửi link thanh toán Đơn hàng 12, vào xem nào quý...',
      'time': '10:30',
      'badge': 'Rau củ',
      'hasUnread': true,
    },
    {
      'id': '2',
      'shopName': 'Nông trại vui vẻ',
      'shopImage': 'assets/images/shop1.png',
      'lastMessage': 'Shop đã gửi link thanh toán Đơn hàng 12, vào xem nào quý...',
      'time': 'Hôm qua',
      'badge': 'Rau củ',
      'hasUnread': false,
    },
    {
      'id': '3',
      'shopName': 'Vườn hữu cơ Simple Life',
      'shopImage': 'assets/images/shop2.png',
      'lastMessage': 'Shop đã gửi link thanh toán Đơn hàng 12, vào xem nào quý...',
      'time': '10:30',
      'badge': 'Trái cây',
      'hasUnread': false,
    },
    {
      'id': '4',
      'shopName': 'Chị Lan - Rau sạch Đà Lạt',
      'shopImage': 'assets/images/shop3.png',
      'lastMessage': 'Shop đã gửi link thanh toán Đơn hàng 12, vào xem nào quý...',
      'time': '2 giờ',
      'badge': 'Rau củ',
      'hasUnread': true,
    },
    {
      'id': '5',
      'shopName': 'Nông trại vui vẻ',
      'shopImage': 'assets/images/shop1.png',
      'lastMessage': 'Shop đã gửi link thanh toán Đơn hàng 12, vào xem nào quý...',
      'time': '10:30',
      'badge': 'Củ quả',
      'hasUnread': true,
    },
    {
      'id': '6',
      'shopName': 'Nông trại bền bỏ sổng',
      'shopImage': 'assets/images/shop4.png',
      'lastMessage': 'Shop đã gửi link thanh toán Đơn hàng 12, vào xem nào quý...',
      'time': '10:30',
      'badge': 'Nấm',
      'hasUnread': false,
    },
    {
      'id': '7',
      'shopName': 'HTX Hòa Trạch',
      'shopImage': 'assets/images/shop5.png',
      'lastMessage': 'Dạ vâng chị, báo chị là tôi đã hoàn thành vào...',
      'time': '1 tuần',
      'badge': 'Rau củ',
      'hasUnread': true,
    },
  ];

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
          'Tin nhắn của tôi',
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
      ),
      body: ListView.builder(
        itemCount: _mockChats.length,
        itemBuilder: (context, index) {
          final chat = _mockChats[index];
          return ChatListItem(
            shopName: chat['shopName'],
            shopImage: chat['shopImage'],
            lastMessage: chat['lastMessage'],
            time: chat['time'],
            badge: chat['badge'],
            hasUnread: chat['hasUnread'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(
                    shopName: chat['shopName'],
                    shopImage: chat['shopImage'],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: AI_Button(),
    );
  }
}