import 'package:flutter/material.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({Key? key}) : super(key: key);

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  String _selectedStatus = 'Tất cả';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF043915)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quản lý đơn hàng',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF043915)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _OrderStatusFilterWidget(
            selectedStatus: _selectedStatus,
            onStatusChanged: (status) {
              setState(() {
                _selectedStatus = status;
              });
            },
          ),
          Expanded(
            child: _OrderListWidget(status: _selectedStatus),
          ),
        ],
      ),
    );
  }
}

class _OrderStatusFilterWidget extends StatelessWidget {
  final String selectedStatus;
  final Function(String) onStatusChanged;

  const _OrderStatusFilterWidget({
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildChip('Tất cả'),
            const SizedBox(width: 8),
            _buildChip('Chờ xử lý'),
            const SizedBox(width: 8),
            _buildChip('Đang giao'),
            const SizedBox(width: 8),
            _buildChip('Hoàn thành'),
            const SizedBox(width: 8),
            _buildChip('Đã hủy'),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    final isSelected = selectedStatus == label;
    return InkWell(
      onTap: () => onStatusChanged(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF043915) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF043915) : const Color(0xFFE0E0E0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 12,
            color: isSelected ? Colors.white : const Color(0xFF666666),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _OrderListWidget extends StatelessWidget {
  final String status;

  const _OrderListWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _OrderCardWidget(
          orderId: '#ORD${1000 + index}',
          customerName: 'Khách hàng ${String.fromCharCode(65 + index)}',
          products: 3 + (index % 4),
          totalAmount: '${(index + 1) * 150}.000đ',
          status: index % 4 == 0 ? 'Chờ xử lý' : index % 4 == 1 ? 'Đang giao' : index % 4 == 2 ? 'Hoàn thành' : 'Đã hủy',
          date: '${20 + index}/11/2024',
        );
      },
    );
  }
}

class _OrderCardWidget extends StatelessWidget {
  final String orderId;
  final String customerName;
  final int products;
  final String totalAmount;
  final String status;
  final String date;

  const _OrderCardWidget({
    required this.orderId,
    required this.customerName,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'Chờ xử lý' 
        ? const Color(0xFFFF9800)
        : status == 'Đang giao' 
            ? const Color(0xFF2196F3)
            : status == 'Hoàn thành'
                ? const Color(0xFF043915)
                : const Color(0xFFE53935);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF043915),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            customerName,
            style: const TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 12,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.inventory_2_outlined, size: 14, color: const Color(0xFF666666)),
              const SizedBox(width: 4),
              Text(
                '$products sản phẩm',
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.calendar_today, size: 14, color: const Color(0xFF666666)),
              const SizedBox(width: 4),
              Text(
                date,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng tiền:',
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
              Text(
                totalAmount,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF043915),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
