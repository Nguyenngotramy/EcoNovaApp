import 'package:flutter/material.dart';
import '../../../widgets/shipper/deliveries/delivery_order.dart';
import 'delivery_detail_screen.dart';
import '../search/search_shipment_screen.dart';
import '../notifications/notification_list_screen.dart';
class DeliveriesListScreen extends StatelessWidget {
  const DeliveriesListScreen({super.key});

  // DỮ LIỆU GIẢ
  List<DeliveryOrder> get _mockOrders => [
    DeliveryOrder(
      orderId: "ST7890QR12",
      senderName: "Nguyễn Thị Diệu Linh",
      senderPhone: "09459145614",
      senderAddress: "14 Phan Thanh, Đà Nẵng",
      receiverName: "Nguyễn Ngô Trà My",
      receiverPhone: "09863271569",
      receiverAddress: "1049 Ngô Quyền, Đà Nẵng",
      statusCode: "pending",
      statusText: "Chờ xử lý",
      fee: "25.000 VND",
      sendTime: "05/11/2025 10:10 AM",
      receiveTime: "06/11/2025 08:43 AM",
    ),
    DeliveryOrder(
      orderId: "GH2345WX56",
      senderName: "Nguyễn Thị Diệu Linh",
      senderPhone: "09459145614",
      senderAddress: "14 Phan Thanh, Đà Nẵng",
      receiverName: "Nguyễn Ngô Trà My",
      receiverPhone: "09863271569",
      receiverAddress: "1049 Ngô Quyền, Đà Nẵng",
      statusCode: "delivering",
      statusText: "Đang giao",
      fee: "25.000 VND",
      sendTime: "05/11/2025 10:10 AM",
      receiveTime: "06/11/2025 08:43 AM",
    ),
    DeliveryOrder(
      orderId: "GH2345WX57",
      senderName: "Nguyễn Thị Diệu Linh",
      senderPhone: "09459145614",
      senderAddress: "14 Phan Thanh, Đà Nẵng",
      receiverName: "Nguyễn Ngô Trà My",
      receiverPhone: "09863271569",
      receiverAddress: "1049 Ngô Quyền, Đà Nẵng",
      statusCode: "done",
      statusText: "Đã giao",
      fee: "25.000 VND",
      sendTime: "05/11/2025 10:10 AM",
      receiveTime: "06/11/2025 08:43 AM",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final orders = _mockOrders;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Giao hàng",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade300, Colors.amber.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Xin chào, Diệu Linh!",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotificationListScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black87),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchShipmentScreen()),
                    );
                  },
                ),

              ],
            ),
          ),

          const SizedBox(height: 12),

          // Date Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "November 5, 2025",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: -0.3,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(context, order);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, DeliveryOrder order) {
    final (statusColor, statusBg) = _getStatusColors(order.statusCode);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DeliveryDetailScreen(order: order),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Order ID + Status
                Row(
                  children: [
                    Icon(Icons.local_shipping_outlined, size: 18, color: Colors.grey.shade600),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mã vận đơn",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            order.orderId,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order.statusText,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                Container(height: 1, color: Colors.grey.shade200),
                const SizedBox(height: 14),

                // Address Section
                Row(
                  children: [
                    Expanded(
                      child: _addressColumn(
                        title: "14 Phan Thanh, ...",
                        subtitle1: "Tên người gửi: ${order.senderName}",
                        subtitle2: "SĐT: ${order.senderPhone}",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade400),
                    ),
                    Expanded(
                      child: _addressColumn(
                        title: "1049 Ngô Quyền, ...",
                        subtitle1: "Tên người nhận: ${order.receiverName}",
                        subtitle2: "SĐT: ${order.receiverPhone}",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                Container(height: 1, color: Colors.grey.shade200),
                const SizedBox(height: 12),

                // Fee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phí giao hàng",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      order.fee,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DeliveryDetailScreen(order: order),
                        ),
                      );
                    },
                    child: const Text(
                      "XEM CHI TIẾT",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget _addressColumn({
    required String title,
    required String subtitle1,
    required String subtitle2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle2,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}