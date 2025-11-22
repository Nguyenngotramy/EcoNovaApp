import 'package:eco_nova_app/theme/app_theme.dart';
import 'package:eco_nova_app/widgets/seller/order/customer_info_card.dart';
import 'package:eco_nova_app/widgets/seller/order/order_product_item.dart';
import 'package:eco_nova_app/widgets/seller/order/order_timeline_item.dart';
import 'package:flutter/material.dart';

import '../../widgets/seller/order/order_summary_card.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String _orderStatus = 'pending'; // pending, confirmed, shipping, completed, cancelled

  Color _getStatusColor() {
    switch (_orderStatus) {
      case 'pending':
        return AppTheme.warningColor;
      case 'confirmed':
        return AppTheme.primary;
      case 'shipping':
        return Colors.blue;
      case 'completed':
        return AppTheme.successColor;
      case 'cancelled':
        return AppTheme.errorColor;
      default:
        return AppTheme.textLight;
    }
  }

  String _getStatusText() {
    switch (_orderStatus) {
      case 'pending':
        return 'Chờ xác nhận';
      case 'confirmed':
        return 'Đã xác nhận';
      case 'shipping':
        return 'Đang giao hàng';
      case 'completed':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  void _showConfirmDialog(String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận $action', style: AppTheme.heading3),
        content: Text(
          'Bạn có chắc chắn muốn $action đơn hàng #${widget.orderId}?',
          style: AppTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                if (action == 'xác nhận') {
                  _orderStatus = 'confirmed';
                } else if (action == 'giao hàng') {
                  _orderStatus = 'shipping';
                } else if (action == 'hoàn thành') {
                  _orderStatus = 'completed';
                } else if (action == 'hủy') {
                  _orderStatus = 'cancelled';
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Đã $action đơn hàng thành công'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: action == 'hủy' ? AppTheme.errorColor : AppTheme.primary,
            ),
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cardBackground,
      appBar: AppBar(
        title: Text('Đơn hàng #${widget.orderId}', style: AppTheme.heading3),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'print') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đang in đơn hàng...')),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'print',
                child: Row(
                  children: [
                    Icon(Icons.print, size: 20),
                    SizedBox(width: 12),
                    Text('In đơn hàng'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppTheme.background,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trạng thái đơn hàng',
                        style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _getStatusColor().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _getStatusColor().withOpacity(0.3)),
                        ),
                        child: Text(
                          _getStatusText(),
                          style: AppTheme.bodyMedium.copyWith(
                            color: _getStatusColor(),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '15/11/2024',
                    style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Timeline
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tiến trình đơn hàng', style: AppTheme.heading3),
                  const SizedBox(height: 20),
                  OrderTimelineItem(
                    title: 'Đơn hàng đã đặt',
                    time: '15/11/2024 14:30',
                    description: 'Đơn hàng đã được tạo và chờ xác nhận',
                    isCompleted: true,
                    isLast: false,
                    icon: Icons.receipt_long,
                  ),
                  OrderTimelineItem(
                    title: 'Đã xác nhận',
                    time: _orderStatus != 'pending' ? '15/11/2024 14:45' : 'Chờ xác nhận',
                    description: _orderStatus != 'pending' 
                        ? 'Người bán đã xác nhận đơn hàng'
                        : null,
                    isCompleted: _orderStatus != 'pending',
                    isLast: false,
                    icon: Icons.check_circle_outline,
                  ),
                  OrderTimelineItem(
                    title: 'Đang giao hàng',
                    time: _orderStatus == 'shipping' || _orderStatus == 'completed'
                        ? '15/11/2024 15:00'
                        : 'Chờ giao hàng',
                    description: _orderStatus == 'shipping' || _orderStatus == 'completed'
                        ? 'Đơn hàng đang được vận chuyển'
                        : null,
                    isCompleted: _orderStatus == 'shipping' || _orderStatus == 'completed',
                    isLast: false,
                    icon: Icons.local_shipping_outlined,
                  ),
                  OrderTimelineItem(
                    title: 'Đã giao hàng',
                    time: _orderStatus == 'completed' ? '15/11/2024 17:30' : 'Chờ giao hàng',
                    description: _orderStatus == 'completed'
                        ? 'Đơn hàng đã được giao thành công'
                        : null,
                    isCompleted: _orderStatus == 'completed',
                    isLast: true,
                    icon: Icons.done_all,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Customer Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomerInfoCard(
                name: 'Nguyễn Văn A',
                phone: '0123 456 789',
                address: '123 Đường ABC, Phường XYZ, Quận 1, TP. Hồ Chí Minh',
                onCall: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đang gọi khách hàng...')),
                  );
                },
                onMessage: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đang mở tin nhắn...')),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Products
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sản phẩm', style: AppTheme.heading3),
                  const SizedBox(height: 16),
                  const OrderProductItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    name: 'Cà chua cherry',
                    weight: '1kg',
                    quantity: 2,
                    price: '40.000đ',
                    totalPrice: '80.000đ',
                  ),
                  const OrderProductItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    name: 'Xà lách xanh',
                    weight: '500g',
                    quantity: 1,
                    price: '25.000đ',
                    totalPrice: '25.000đ',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Order Summary
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: OrderSummaryCard(
                subtotal: '105.000đ',
                shippingFee: '15.000đ',
                total: '120.000đ',
              ),
            ),

            const SizedBox(height: 16),

            // Notes
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ghi chú', style: AppTheme.heading3),
                  const SizedBox(height: 8),
                  Text(
                    'Giao hàng trước 5 giờ chiều. Gọi trước khi giao.',
                    style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: _orderStatus == 'cancelled' || _orderStatus == 'completed'
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppTheme.background,
                border: Border(
                  top: BorderSide(color: AppTheme.borderColor),
                ),
              ),
              child: SafeArea(
                child: _buildActionButtons(),
              ),
            ),
    );
  }

  Widget _buildActionButtons() {
    if (_orderStatus == 'pending') {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _showConfirmDialog('hủy'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.errorColor,
                side: const BorderSide(color: AppTheme.errorColor),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Từ chối'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showConfirmDialog('xác nhận'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Xác nhận'),
            ),
          ),
        ],
      );
    } else if (_orderStatus == 'confirmed') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _showConfirmDialog('giao hàng'),
          icon: const Icon(Icons.local_shipping_outlined),
          label: const Text('Bắt đầu giao hàng'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      );
    } else if (_orderStatus == 'shipping') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _showConfirmDialog('hoàn thành'),
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('Xác nhận đã giao'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: AppTheme.successColor,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}