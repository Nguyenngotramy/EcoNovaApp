
import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/presentation/widgets/seller/order/compact_order_card.dart';
import 'package:eco_nova_app/presentation/widgets/seller/order/order_filter_chip.dart';
import 'package:eco_nova_app/presentation/widgets/seller/order/order_stats_row.dart';
import 'package:eco_nova_app/presentation/widgets/seller/products/search_filter_bar.dart';
import 'package:flutter/material.dart';
import 'order_detail_screen.dart';

class CompleteOrderListScreen extends StatefulWidget {
  const CompleteOrderListScreen({Key? key}) : super(key: key);

  @override
  State<CompleteOrderListScreen> createState() => _CompleteOrderListScreenState();
}

class _CompleteOrderListScreenState extends State<CompleteOrderListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  String _sortBy = 'newest';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sắp xếp theo', style: AppTheme.heading2),
            const SizedBox(height: 16),
            _buildSortOption('Mới nhất', 'newest'),
            _buildSortOption('Cũ nhất', 'oldest'),
            _buildSortOption('Giá cao nhất', 'price_high'),
            _buildSortOption('Giá thấp nhất', 'price_low'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String label, String value) {
    final isSelected = _sortBy == value;
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: _sortBy,
      activeColor: AppTheme.primary,
      onChanged: (val) {
        setState(() {
          _sortBy = val!;
        });
        Navigator.pop(context);
      },
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }

  void _showDateFilter() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lọc theo thời gian', style: AppTheme.heading2),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.today),
              title: const Text('Hôm nay'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('7 ngày qua'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('30 ngày qua'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Tùy chọn'),
              onTap: () async {
                Navigator.pop(context);
                await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredOrders() {
    final allOrders = [
      {
        'id': 'DH001',
        'customer': 'Nguyễn Văn A',
        'avatar': 'https://via.placeholder.com/150',
        'items': 3,
        'total': '200.000đ',
        'time': '10 phút trước',
        'status': 'pending',
        'statusText': 'Chờ xác nhận',
        'statusColor': AppTheme.warningColor,
      },
      {
        'id': 'DH002',
        'customer': 'Trần Thị B',
        'avatar': 'https://via.placeholder.com/150',
        'items': 2,
        'total': '150.000đ',
        'time': '25 phút trước',
        'status': 'pending',
        'statusText': 'Chờ xác nhận',
        'statusColor': AppTheme.warningColor,
      },
      {
        'id': 'DH003',
        'customer': 'Lê Văn C',
        'avatar': 'https://via.placeholder.com/150',
        'items': 5,
        'total': '350.000đ',
        'time': '1 giờ trước',
        'status': 'confirmed',
        'statusText': 'Đã xác nhận',
        'statusColor': AppTheme.primary,
      },
      {
        'id': 'DH004',
        'customer': 'Phạm Thị D',
        'avatar': 'https://via.placeholder.com/150',
        'items': 4,
        'total': '280.000đ',
        'time': '2 giờ trước',
        'status': 'shipping',
        'statusText': 'Đang giao',
        'statusColor': Colors.blue,
      },
      {
        'id': 'DH005',
        'customer': 'Hoàng Văn E',
        'avatar': 'https://via.placeholder.com/150',
        'items': 2,
        'total': '120.000đ',
        'time': '3 giờ trước',
        'status': 'shipping',
        'statusText': 'Đang giao',
        'statusColor': Colors.blue,
      },
      {
        'id': 'DH006',
        'customer': 'Vũ Thị F',
        'avatar': 'https://via.placeholder.com/150',
        'items': 6,
        'total': '450.000đ',
        'time': 'Hôm qua',
        'status': 'completed',
        'statusText': 'Hoàn thành',
        'statusColor': AppTheme.successColor,
      },
      {
        'id': 'DH007',
        'customer': 'Đỗ Văn G',
        'avatar': 'https://via.placeholder.com/150',
        'items': 3,
        'total': '180.000đ',
        'time': '2 ngày trước',
        'status': 'cancelled',
        'statusText': 'Đã hủy',
        'statusColor': AppTheme.errorColor,
      },
    ];

    if (_selectedFilter == 'all') return allOrders;
    return allOrders.where((order) => order['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _getFilteredOrders();

    return Scaffold(
      backgroundColor: AppTheme.cardBackground,
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng', style: AppTheme.heading2),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: _showDateFilter,
            tooltip: 'Lọc theo ngày',
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
            tooltip: 'Sắp xếp',
          ),
        ],
      ),
      body: Column(
        children: [
          OrderStatsRow(
            totalOrders: 125,
            pendingOrders: 12,
            shippingOrders: 8,
            completedToday: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchFilterBar(
              searchController: _searchController,
              onFilterTap: _showDateFilter,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                OrderFilterChip(
                  label: 'Tất cả',
                  count: 125,
                  isSelected: _selectedFilter == 'all',
                  onTap: () => setState(() => _selectedFilter = 'all'),
                ),
                const SizedBox(width: 8),
                OrderFilterChip(
                  label: 'Chờ xác nhận',
                  count: 12,
                  isSelected: _selectedFilter == 'pending',
                  onTap: () => setState(() => _selectedFilter = 'pending'),
                  color: AppTheme.warningColor,
                ),
                const SizedBox(width: 8),
                OrderFilterChip(
                  label: 'Đã xác nhận',
                  count: 8,
                  isSelected: _selectedFilter == 'confirmed',
                  onTap: () => setState(() => _selectedFilter = 'confirmed'),
                  color: AppTheme.primary,
                ),
                const SizedBox(width: 8),
                OrderFilterChip(
                  label: 'Đang giao',
                  count: 15,
                  isSelected: _selectedFilter == 'shipping',
                  onTap: () => setState(() => _selectedFilter = 'shipping'),
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                OrderFilterChip(
                  label: 'Hoàn thành',
                  isSelected: _selectedFilter == 'completed',
                  onTap: () => setState(() => _selectedFilter = 'completed'),
                  color: AppTheme.successColor,
                ),
                const SizedBox(width: 8),
                OrderFilterChip(
                  label: 'Đã hủy',
                  isSelected: _selectedFilter == 'cancelled',
                  onTap: () => setState(() => _selectedFilter = 'cancelled'),
                  color: AppTheme.errorColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Không có đơn hàng',
                          style: AppTheme.heading3.copyWith(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Chưa có đơn hàng nào trong mục này',
                          style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return CompactOrderCard(
                        orderId: order['id'],
                        customerName: order['customer'],
                        customerAvatar: order['avatar'],
                        itemCount: order['items'],
                        totalAmount: order['total'],
                        orderTime: order['time'],
                        status: order['statusText'],
                        statusColor: order['statusColor'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailScreen(
                                orderId: order['id'],
                              ),
                            ),
                          );
                        },
                        quickActionLabel: order['status'] == 'pending' 
                            ? 'Xác nhận'
                            : order['status'] == 'confirmed'
                            ? 'Giao hàng'
                            : null,
                        onQuickAction: order['status'] == 'pending' ||
                                order['status'] == 'confirmed'
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Đã ${order['status'] == 'pending' ? 'xác nhận' : 'bắt đầu giao'} đơn hàng #${order['id']}',
                                    ),
                                    backgroundColor: AppTheme.successColor,
                                  ),
                                );
                              }
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}