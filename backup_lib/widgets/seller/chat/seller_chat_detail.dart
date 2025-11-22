import 'package:flutter/material.dart';
import 'package:eco_nova_app/theme/app_theme.dart';

class SellerChatDetailScreen extends StatefulWidget {
  final String customerName;
  final String customerImage;

  const SellerChatDetailScreen({
    super.key,
    required this.customerName,
    required this.customerImage,
  });

  @override
  State<SellerChatDetailScreen> createState() => _SellerChatDetailScreenState();
}

class _SellerChatDetailScreenState extends State<SellerChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock messages - Góc nhìn người bán
  final List<Map<String, dynamic>> _messages = [
    {
      'type': 'received',
      'message': 'Cà chua này ngọt không shop, giao nhanh dùm em, chiều em muốn ăn',
      'time': '9:00',
    },
    {
      'type': 'product',
      'productName': 'Cà chua bi organic',
      'productPrice': '45.000VNĐ',
      'productImage': 'assets/images/1.jpg',
    },
    {
      'type': 'sent',
      'message': 'Dạ ngọt lắm chị, mà shop liên hệ cho bạn giao hàng ạ, bên shop có mấy quả nho thử không shop gửi cho',
      'time': '9:15',
    },
    {
      'type': 'received',
      'message': 'OK luôn shop đúng lúc em đang thèm',
      'time': '9:16',
    },
    {
      'type': 'sent',
      'message': '30 phút nữa shop giao hàng nhé khách ạ, shop mới ship hóa đơn cho khách',
      'time': '9:20',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'type': 'sent',
        'message': _messageController.text,
        'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      });
    });

    _messageController.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    if (message['type'] == 'product') {
      return _buildProductCard(message);
    }

    final bool isSent = message['type'] == 'sent';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSent) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(widget.customerImage),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSent ? AppTheme.primary : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message['message'],
                    style: AppTheme.bodyMedium.copyWith(
                      color: isSent ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message['time'],
                  style: AppTheme.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 200,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product['productImage'],
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 48,
                        height: 48,
                        color: AppTheme.secondaryLight,
                        child: const Icon(Icons.image, color: AppTheme.primary),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['productName'],
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product['productPrice'],
                        style: AppTheme.price.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(widget.customerImage),
            ),
            const SizedBox(width: 12),
            Expanded(
                  child: Text(
                    widget.customerName,
                    style: AppTheme.heading3.copyWith(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_outlined, color: AppTheme.primary),
            onPressed: () {
              // Handle call customer
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.primary),
            onPressed: () {
              // Handle more options
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: AppTheme.borderColor, width: 1),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Quick action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickActionButton('Sản phẩm', Icons.inventory_2_outlined),
                      _buildQuickActionButton('Đơn hàng', Icons.receipt_long_outlined),
                      _buildQuickActionButton('Khuyến mãi', Icons.sell_outlined),
                      _buildQuickActionButton('Thanh toán', Icons.payment_outlined),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Input row
                  Row(
                    children: [
                      // Attachment button
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white, size: 20),
                          onPressed: () {
                            _showAttachmentOptions(context);
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Message input
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.cardBackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _messageController,
                                  decoration: const InputDecoration(
                                    hintText: 'Nhập tin nhắn...',
                                    hintStyle: TextStyle(
                                      color: AppTheme.textLight,
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                  style: AppTheme.bodyMedium,
                                  maxLines: null,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.mic, color: AppTheme.textLight, size: 20),
                                onPressed: () {
                                  // Handle voice message
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Send button
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white, size: 20),
                          onPressed: _sendMessage,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Handle quick action
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppTheme.primary),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.caption.copyWith(
              fontSize: 10,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.inventory_2_outlined, color: AppTheme.primary),
              title: const Text('Gửi sản phẩm'),
              onTap: () {
                Navigator.pop(context);
                // Handle send product
              },
            ),
            ListTile(
              leading: const Icon(Icons.image_outlined, color: AppTheme.primary),
              title: const Text('Gửi hình ảnh'),
              onTap: () {
                Navigator.pop(context);
                // Handle send image
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined, color: AppTheme.primary),
              title: const Text('Gửi đơn hàng'),
              onTap: () {
                Navigator.pop(context);
                // Handle send order
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment_outlined, color: AppTheme.primary),
              title: const Text('Gửi link thanh toán'),
              onTap: () {
                Navigator.pop(context);
                // Handle send payment link
              },
            ),
          ],
        ),
      ),
    );
  }
}