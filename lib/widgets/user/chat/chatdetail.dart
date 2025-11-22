import 'package:flutter/material.dart';
import 'package:eco_nova_app/theme/app_theme.dart';

class ChatDetailScreen extends StatefulWidget {
  final String shopName;
  final String shopImage;

  const ChatDetailScreen({
    super.key,
    required this.shopName,
    required this.shopImage,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock messages
  final List<Map<String, dynamic>> _messages = [
    {
      'type': 'received',
      'message': 'Cả chua này ngọt không sếp, giao nhanh đúm e, ck e muộn án',
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
      'message': 'ok, mà xếp liên liệp cho bạn nhà khách iu, bên sếp có mấy cụ nhét thử không sếp gửi cho',
      'time': '9:15',
    },
    {
      'type': 'received',
      'message': 'OK luôn sếp đúng lúc e đang thèm',
      'time': '9:16',
    },
    {
      'type': 'sent',
      'message': '300giud nuk cà nhân hàng nhà khách e mới ship hoá tóc cho khách',
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
              backgroundImage: AssetImage(widget.shopImage),
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
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(widget.shopImage),
          ),
          const SizedBox(width: 8),
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
                GestureDetector(
                  onTap: () {
                    // Handle add to cart
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
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
              backgroundImage: AssetImage(widget.shopImage),
            ),
            const SizedBox(width: 12),
            Text(
              widget.shopName,
              style: AppTheme.heading3.copyWith(fontSize: 16),
            ),
          ],
        ),
        actions: [
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
                  // Input row
                  Row(
                    children: [
                      // Action buttons
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.attach_file, color: Colors.white, size: 20),
                          onPressed: () {
                            // Handle attachment
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
                                    hintText: 'Nhập tin nhắn',
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
                  const SizedBox(height: 12),
                  // Bottom buttons row
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     _buildBottomButton('Kiểm tra giá', Icons.info_outline),
                  //     _buildBottomButton('Thông tin giao hàng', Icons.local_shipping_outlined),
                  //     _buildBottomButton('Khuyến mãi', Icons.sell_outlined),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(String label, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton(
          onPressed: () {
            // Handle button action
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.textPrimary,
            side: const BorderSide(color: AppTheme.borderColor),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: AppTheme.primary),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTheme.caption.copyWith(
                  fontSize: 10,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}