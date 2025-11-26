import 'package:flutter/material.dart';
import '../../../widgets/shipper/deliveries/delivery_order.dart';

class DeliveryDetailScreen extends StatelessWidget {
  final DeliveryOrder order;

  const DeliveryDetailScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPending = order.statusCode == "pending";
    final bool isDelivering = order.statusCode == "delivering";

    final (statusColor, statusBg) = _getStatusColors(order.statusCode);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // MAP + BACK BUTTON
          SizedBox(
            height: 260,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.grey.shade300,
                    child: Image.asset(
                      'assets/images/mock_map.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.map, size: 64, color: Colors.grey.shade400),
                        );
                      },
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        _buildIconButton(
                          icon: Icons.arrow_back,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        _buildIconButton(
                          icon: Icons.my_location_outlined,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // CONTENT BELOW MAP
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expected Delivery Time + Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Thời gian giao hàng dự kiến",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "10:23 AM",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order.statusText,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: statusColor,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),
                    _buildDivider(),
                    const SizedBox(height: 18),

                    // TIMELINE
                    _buildTimelineSection(),

                    const SizedBox(height: 18),
                    _buildDivider(),
                    const SizedBox(height: 18),

                    // SENDER / RECEIVER INFO
                    _buildPersonInfoSection(order),

                    const SizedBox(height: 18),
                    _buildDivider(),
                    const SizedBox(height: 18),

                    // PAYMENT INFO
                    _buildPaymentSection(order),

                    const SizedBox(height: 24),

                    // BUTTONS
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              side: const BorderSide(
                                color: Color(0xFFFFA000),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // TODO: xử lý không thành công
                            },
                            child: const Text(
                              "KHÔNG THÀNH CÔNG",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFA000),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1B5E20),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              // TODO: xử lý đã giao hàng
                            },
                            child: const Text(
                              "ĐÃ GIAO HÀNG",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87, size: 20),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.grey.shade200,
    );
  }

  (Color, Color) _getStatusColors(String statusCode) {
    switch (statusCode) {
      case "pending":
        return (const Color(0xFFE65100), const Color(0xFFFFF3E0));
      case "delivering":
        return (const Color(0xFF2E7D32), const Color(0xFFE8F5E9));
      case "done":
        return (const Color(0xFF2E7D32), const Color(0xFFE8F5E9));
      default:
        return (Colors.grey, Colors.grey.shade100);
    }
  }

  Widget _buildTimelineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timelineRow(
          isActive: true,
          time: "05/11/2025\n10:10 AM",
          title: "Đơn hàng đang được vận chuyển",
        ),
        const SizedBox(height: 20),
        _timelineRow(
          isActive: true,
          time: "06/11/2025\n08:43 AM",
          title: "Đã lấy đơn thành công",
        ),
      ],
    );
  }

  Widget _timelineRow({
    required bool isActive,
    required String time,
    required String title,
  }) {
    final Color color = isActive ? const Color(0xFF1B5E20) : Colors.grey.shade400;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TIMELINE DOT
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 13, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(width: 14),
        // TEXT
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPersonInfoSection(DeliveryOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _twoColumnRow(
          leftTitle: "Tên người gửi",
          leftValue: order.senderName,
          rightTitle: "SĐT người gửi",
          rightValue: order.senderPhone,
        ),
        const SizedBox(height: 12),
        _twoColumnRow(
          leftTitle: "Tên người nhận",
          leftValue: order.receiverName,
          rightTitle: "SĐT người nhận",
          rightValue: order.receiverPhone,
        ),
      ],
    );
  }

  Widget _buildPaymentSection(DeliveryOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phương thức thanh toán: Thanh toán khi nhận hàng",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Phí giao hàng:",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              order.fee,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B5E20),
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _twoColumnRow({
    required String leftTitle,
    required String leftValue,
    required String rightTitle,
    required String rightValue,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leftTitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                leftValue,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rightTitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                rightValue,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}