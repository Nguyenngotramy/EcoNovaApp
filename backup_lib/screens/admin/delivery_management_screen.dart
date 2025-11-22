import 'package:flutter/material.dart';

class DeliveryManagementScreen extends StatefulWidget {
  const DeliveryManagementScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryManagementScreen> createState() => _DeliveryManagementScreenState();
}

class _DeliveryManagementScreenState extends State<DeliveryManagementScreen> {
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
          'Quản lý giao hàng',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map, color: Color(0xFF043915)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _DeliveryStatusWidget(),
          const SizedBox(height: 16),
          _DeliveryFilterWidget(
            selectedStatus: _selectedStatus,
            onStatusChanged: (status) {
              setState(() {
                _selectedStatus = status;
              });
            },
          ),
          Expanded(
            child: _DeliveryListWidget(status: _selectedStatus),
          ),
        ],
      ),
    );
  }
}

class _DeliveryStatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatusItem('Đang xử lý', '15', const Color(0xFFFF9800)),
          _buildStatusItem('Đang giao', '23', const Color(0xFF2196F3)),
          _buildStatusItem('Đã giao', '142', const Color(0xFF043915)),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            count,
            style: TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
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

class _DeliveryFilterWidget extends StatelessWidget {
  final String selectedStatus;
  final Function(String) onStatusChanged;

  const _DeliveryFilterWidget({
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildChip('Tất cả'),
            const SizedBox(width: 8),
            _buildChip('Đang xử lý'),
            const SizedBox(width: 8),
            _buildChip('Đang giao'),
            const SizedBox(width: 8),
            _buildChip('Đã giao'),
            const SizedBox(width: 8),
            _buildChip('Có vấn đề'),
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

class _DeliveryListWidget extends StatelessWidget {
  final String status;

  const _DeliveryListWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _DeliveryCardWidget(
          orderId: '#ORD${1000 + index}',
          shipperName: 'Shipper ${String.fromCharCode(65 + index)}',
          customerName: 'Nguyễn Văn ${String.fromCharCode(65 + index)}',
          address: 'Số ${index + 1}, Đường ABC, Quận 1, TP.HCM',
          status: index % 4 == 0 ? 'Đang xử lý' : index % 4 == 1 ? 'Đang giao' : index % 4 == 2 ? 'Đã giao' : 'Có vấn đề',
          distance: '${(index + 1) * 0.5} km',
          estimatedTime: '${15 + (index * 5)} phút',
        );
      },
    );
  }
}

class _DeliveryCardWidget extends StatelessWidget {
  final String orderId;
  final String shipperName;
  final String customerName;
  final String address;
  final String status;
  final String distance;
  final String estimatedTime;

  const _DeliveryCardWidget({
    required this.orderId,
    required this.shipperName,
    required this.customerName,
    required this.address,
    required this.status,
    required this.distance,
    required this.estimatedTime,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'Đang xử lý' 
        ? const Color(0xFFFF9800)
        : status == 'Đang giao' 
            ? const Color(0xFF2196F3)
            : status == 'Đã giao'
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
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.delivery_dining, size: 16, color: Color(0xFF666666)),
              const SizedBox(width: 8),
              Text(
                shipperName,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF043915),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person, size: 16, color: Color(0xFF666666)),
              const SizedBox(width: 8),
              Text(
                customerName,
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 16, color: Color(0xFF666666)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
            ],
          ),
          if (status == 'Đang giao') ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.near_me, size: 14, color: const Color(0xFF2196F3)),
                const SizedBox(width: 4),
                Text(
                  distance,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 11,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 14, color: const Color(0xFF2196F3)),
                const SizedBox(width: 4),
                Text(
                  'Còn $estimatedTime',
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 11,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ],
          if (status == 'Có vấn đề') ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, size: 16, color: Color(0xFFE53935)),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Không liên hệ được khách hàng',
                      style: TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 11,
                        color: Color(0xFFE53935),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF043915),
                    side: const BorderSide(color: Color(0xFF043915)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'Chi tiết',
                    style: TextStyle(
                      fontFamily: 'Be Vietnam Pro',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF043915),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'Theo dõi',
                    style: TextStyle(
                      fontFamily: 'Be Vietnam Pro',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}