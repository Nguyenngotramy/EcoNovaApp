import 'package:eco_nova_app/widgets/user/component/ai_button.dart';
import 'package:eco_nova_app/widgets/user/chat/chat_list_item.dart';
import 'package:eco_nova_app/widgets/user/chat/chatdetail.dart';
import 'package:flutter/material.dart';
import 'package:eco_nova_app/theme/app_theme.dart';

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
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: AppTheme.primary),
                onPressed: () {
                  // Handle cart
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
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