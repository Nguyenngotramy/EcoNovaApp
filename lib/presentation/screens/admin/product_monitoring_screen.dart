import 'package:flutter/material.dart';

class ProductMonitoringScreen extends StatefulWidget {
  const ProductMonitoringScreen({Key? key}) : super(key: key);

  @override
  State<ProductMonitoringScreen> createState() => _ProductMonitoringScreenState();
}

class _ProductMonitoringScreenState extends State<ProductMonitoringScreen> {
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
          'Giám sát sản phẩm',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF043915)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _ProductStatusFilterWidget(
            selectedStatus: _selectedStatus,
            onStatusChanged: (status) {
              setState(() {
                _selectedStatus = status;
              });
            },
          ),
          Expanded(
            child: _ProductListWidget(status: _selectedStatus),
          ),
        ],
      ),
    );
  }
}

class _ProductStatusFilterWidget extends StatelessWidget {
  final String selectedStatus;
  final Function(String) onStatusChanged;

  const _ProductStatusFilterWidget({
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
            _buildChip('Chờ duyệt'),
            const SizedBox(width: 8),
            _buildChip('Đã duyệt'),
            const SizedBox(width: 8),
            _buildChip('Vi phạm'),
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

class _ProductListWidget extends StatelessWidget {
  final String status;

  const _ProductListWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 8,
      itemBuilder: (context, index) {
        return _ProductCardWidget(
          name: 'Sản phẩm ${index + 1}',
          supplier: 'Nhà cung cấp ${String.fromCharCode(65 + index)}',
          price: '${(index + 1) * 50}.000đ',
          status: index % 3 == 0 ? 'Chờ duyệt' : index % 3 == 1 ? 'Đã duyệt' : 'Vi phạm',
          imageUrl: 'https://via.placeholder.com/100',
        );
      },
    );
  }
}

class _ProductCardWidget extends StatelessWidget {
  final String name;
  final String supplier;
  final String price;
  final String status;
  final String imageUrl;

  const _ProductCardWidget({
    required this.name,
    required this.supplier,
    required this.price,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'Chờ duyệt' 
        ? const Color(0xFFFF9800)
        : status == 'Đã duyệt' 
            ? const Color(0xFF043915)
            : const Color(0xFFE53935);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: Color(0xFFE0E0E0), size: 40),
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
                  supplier,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF043915),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
          ),
          if (status == 'Chờ duyệt')
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.check_circle, color: Color(0xFF043915)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Color(0xFFE53935)),
                  onPressed: () {},
                ),
              ],
            ),
        ],
      ),
    );
  }
}