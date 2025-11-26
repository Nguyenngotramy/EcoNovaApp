import 'package:flutter/material.dart';

class ShipperManagementScreen extends StatelessWidget {
  const ShipperManagementScreen({Key? key}) : super(key: key);

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
          'Quản lý shipper',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (context, index) {
          return _ShipperCardWidget(
            name: 'Shipper ${String.fromCharCode(65 + index)}',
            phone: '0${900000000 + index}',
            totalOrders: 45 + index * 5,
            rating: 4.5 - (index * 0.1),
            status: index % 3 == 0 ? 'Đang giao' : 'Sẵn sàng',
          );
        },
      ),
    );
  }
}

class _ShipperCardWidget extends StatelessWidget {
  final String name;
  final String phone;
  final int totalOrders;
  final double rating;
  final String status;

  const _ShipperCardWidget({
    required this.name,
    required this.phone,
    required this.totalOrders,
    required this.rating,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
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
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFF4C763B).withOpacity(0.1),
                child: const Icon(Icons.delivery_dining, color: Color(0xFF4C763B)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF043915),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: status == 'Đang giao' 
                      ? const Color(0xFFFF9800).withOpacity(0.1)
                      : const Color(0xFF043915).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 10,
                    color: status == 'Đang giao' ? const Color(0xFFFF9800) : const Color(0xFF043915),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoItem(Icons.shopping_bag_outlined, '$totalOrders đơn'),
              const SizedBox(width: 16),
              _buildInfoItem(Icons.star, '$rating sao'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF666666)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
