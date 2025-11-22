import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

// Component: Order Status Badge
class OrderStatusBadge extends StatelessWidget {
  final String status; // 'completed', 'pending', 'waiting', 'cancelled'

  const OrderStatusBadge({
    super.key,
    required this.status,
  });

  Map<String, dynamic> _getStatusConfig() {
    switch (status) {
      case 'completed':
        return {
          'text': 'Hoàn thành',
          'color': AppTheme.successColor,
          'bgColor': AppTheme.successColor.withOpacity(0.1),
        };
      case 'pending':
        return {
          'text': 'Đang giao',
          'color': const Color(0xFF2196F3),
          'bgColor': const Color(0xFF2196F3).withOpacity(0.1),
        };
      case 'waiting':
        return {
          'text': 'Chờ xác nhận',
          'color': AppTheme.warningColor,
          'bgColor': AppTheme.warningColor.withOpacity(0.1),
        };
      default: // cancelled
        return {
          'text': 'Đã hủy',
          'color': AppTheme.errorColor,
          'bgColor': AppTheme.errorColor.withOpacity(0.1),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: config['bgColor'],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        config['text'],
        style: AppTheme.bodySmall.copyWith(
          color: config['color'],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Component: Order Product Item
class OrderProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String shopName;
  final double price;
  final int quantity;

  const OrderProductItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.shopName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.cardBackground,
                    child: const Icon(
                      Icons.image_outlined,
                      color: AppTheme.textLight,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  shopName,
                  style: AppTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}VNĐ',
                  style: AppTheme.price,
                ),
              ],
            ),
          ),
          // Quantity
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'x$quantity',
              style: AppTheme.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Component: Order Action Buttons
class OrderActionButtons extends StatelessWidget {
  final String status;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;

  const OrderActionButtons({
    super.key,
    required this.status,
    this.onPrimaryAction,
    this.onSecondaryAction,
  });

  Map<String, String> _getButtonLabels() {
    switch (status) {
      case 'completed':
        return {
          'primary': 'Mua lại',
          'secondary': 'Đánh giá',
        };
      case 'pending':
        return {
          'primary': 'Theo dõi đơn hàng',
          'secondary': 'Liên hệ shop',
        };
      case 'waiting':
        return {
          'primary': 'Liên hệ shop',
          'secondary': 'Hủy đơn',
        };
      default: // cancelled
        return {
          'primary': 'Mua lại',
          'secondary': 'Xóa đơn hàng',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final labels = _getButtonLabels();
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onSecondaryAction,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primary,
              side: const BorderSide(color: AppTheme.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              labels['secondary']!,
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onPrimaryAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              labels['primary']!,
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Main Component: Order Card
class OrderCard extends StatelessWidget {
  final String orderTitle;
  final String orderCode;
  final String orderDate;
  final String status;
  final List<Map<String, dynamic>> products;
  final double totalAmount;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;

  const OrderCard({
    super.key,
    required this.orderTitle,
    required this.orderCode,
    required this.orderDate,
    required this.status,
    required this.products,
    required this.totalAmount,
    this.onPrimaryAction,
    this.onSecondaryAction,
  });

  int get _totalProducts => products.fold(0, (sum, item) => sum + (item['quantity'] as int));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Order Info & Status
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderTitle,
                        style: AppTheme.heading3,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'MĐH: $orderCode - $orderDate',
                        style: AppTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                OrderStatusBadge(status: status),
              ],
            ),
          ),
          const Divider(height: 1, color: AppTheme.borderColor),
          
          // Products List
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: products.map((product) {
                return OrderProductItem(
                  name: product['name'],
                  imageUrl: product['imageUrl'],
                  shopName: product['shopName'],
                  price: product['price'],
                  quantity: product['quantity'],
                );
              }).toList(),
            ),
          ),
          
          const Divider(height: 1, color: AppTheme.borderColor),
          
          // Total Amount
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng cộng ($_totalProducts sản phẩm):',
                  style: AppTheme.price.copyWith(fontSize: 12),
                ),
                Text(
                  '${totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} VNĐ',
                  style: AppTheme.heading3.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: OrderActionButtons(
              status: status,
              onPrimaryAction: onPrimaryAction,
              onSecondaryAction: onSecondaryAction,
            ),
          ),
        ],
      ),
    );
  }
}