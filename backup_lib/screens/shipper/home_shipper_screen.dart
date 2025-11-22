import 'package:flutter/material.dart';
import '../../widgets/shipper/notifications/notification_list_screen.dart';
import '../../widgets/shipper/search/search_shipment_screen.dart';
class HomeShipperScreen extends StatefulWidget {
  const HomeShipperScreen({super.key});

  @override
  State<HomeShipperScreen> createState() => _HomeShipperScreenState();
}

class _HomeShipperScreenState extends State<HomeShipperScreen> {
  String selectedFilter = 'Đang vận chuyển';

  // ================== LIST ĐƠN HÀNG ==================
  final List<ShipmentData> deliveringShipments = [
    ShipmentData(
      id: 'ST779890R12',
      price: '25,000',
      fromAddress: '14 Phan Thanh...',
      toAddress: '104/9 Ngô Quyền...',
      recipientName: 'Nguyễn Ngô Trà My',
      recipientPhone: '09652371569',
      status: 'Đang vận chuyển',
    ),
  ];

  final List<IncomingShipment> incomingShipments = [
    IncomingShipment(
      id: 'ST779890R12',
      price: '25,000',
      fromAddress: '14 Phan Thanh...',
      toAddress: '104/9 Ngô Quyền...',
      recipientName: 'Nguyễn Ngô Trà My',
      recipientPhone: '09652371569',
      status: 'Đang đến',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),

      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildLocationHeader(),
          _buildFilterButtons(),
          Expanded(
            child: selectedFilter == "Đang vận chuyển"
                ? _buildDeliveringList()
                : _buildIncomingList(),
          ),
        ],
      ),
    );
  }

  // ======================= APP BAR ========================
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.amber[300],
          child: const Text('DL',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Xin chào, Diệu Linh!',
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
          Text('470 Trần Đại Nghĩa • Hoà Quý • Đà Nẵng',
              style: TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
      actions: [
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
    );
  }

  // ======================= LOCATION ========================
  Widget _buildLocationHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.location_on, size: 15, color: Colors.green[700]),
          const SizedBox(width: 6),
          const Text(
            '470 Trần Đại Nghĩa, p Hoà Quý, TP Đà Nẵng',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // ======================= FILTER BUTTONS ========================
  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _filterTab('Đang vận chuyển'),
          const SizedBox(width: 12),
          _filterTab('Đang đến'),
        ],
      ),
    );
  }

  Widget _filterTab(String text) {
    bool active = selectedFilter == text;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = text),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF1B5E20) : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: active ? Colors.white : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  // ======================= LIST — ĐANG VẬN CHUYỂN ========================
  Widget _buildDeliveringList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: deliveringShipments.length,
      itemBuilder: (context, index) {
        return ShipmentCard(
          data: deliveringShipments[index],
          onFailedPressed: () => _dialogFail(),
          onDeliveredPressed: () => _dialogDelivered(),
        );
      },
    );
  }

  // ======================= LIST — ĐANG ĐẾN ========================
  Widget _buildIncomingList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: incomingShipments.length,
      itemBuilder: (context, index) {
        return IncomingShipmentCard(
          data: incomingShipments[index],
          onDecline: () => _dialogConfirmDecline(),
          onAccept: () => _dialogConfirmAccept(),
        );
      },
    );
  }

  // ======================= DIALOGS ========================
  void _dialogFail() {
    _showDialog(
      title: "Giao hàng thất bại",
      message:
      "Lần giao hàng này sẽ được ghi nhận.\nVui lòng liên hệ quản lý kinh doanh.",
    );
  }

  void _dialogDelivered() {
    _showDialog(
      title: "Giao hàng thành công",
      message:
      "Bạn đã giao hàng thành công.\nVui lòng liên hệ quản lý kinh doanh.",
    );
  }

  void _dialogConfirmDecline() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận từ chối giao hàng"),
        content: const Text("Bạn có chắc chắn muốn từ chối đơn hàng này?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy bỏ"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showDialog(title: "Từ chối", message: "Bạn đã từ chối đơn hàng.");
            },
            child: const Text("Đồng ý"),
          ),
        ],
      ),
    );
  }

  void _dialogConfirmAccept() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận chấp nhận giao hàng"),
        content: const Text("Bạn đã sẵn sàng nhận giao hàng chưa?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy bỏ"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showDialog(
                title: "Đã chấp nhận giao hàng",
                message:
                "Bạn đã chấp nhận đơn giao hàng.\nXem chi tiết trong mục giao hàng.",
              );
            },
            child: const Text("Đồng ý"),
          ),
        ],
      ),
    );
  }

  void _showDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

// =============================================
// MODEL ĐƠN
// =============================================
class ShipmentData {
  final String id, price, fromAddress, toAddress, recipientName, recipientPhone, status;

  ShipmentData({
    required this.id,
    required this.price,
    required this.fromAddress,
    required this.toAddress,
    required this.recipientName,
    required this.recipientPhone,
    required this.status,
  });
}

// CARD giao hàng đang vận chuyển
class ShipmentCard extends StatelessWidget {
  final ShipmentData data;
  final VoidCallback onFailedPressed;
  final VoidCallback onDeliveredPressed;

  const ShipmentCard({
    super.key,
    required this.data,
    required this.onFailedPressed,
    required this.onDeliveredPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 12),
            _addresses(),
            const SizedBox(height: 16),
            _timeline(),
            const SizedBox(height: 16),
            _buttons(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.confirmation_number, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 6),
            const Text("Mã vận đơn", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        Text("${data.price} VNĐ",
            style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _addresses() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.fromAddress, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text("Tên người nhận: ${data.recipientName}",
                  style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.toAddress, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text("SĐT người nhận: ${data.recipientPhone}",
                  style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timeline() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _timelineRow(true, Icons.local_shipping, "12/01/2025 08:30 AM", "Đơn hàng đang được vận chuyển"),
          const SizedBox(height: 12),
          _timelineRow(false, Icons.check_circle_outline, "12/01/2025 08:12 AM", "Đơn hàng đã được lấy"),
        ],
      ),
    );
  }

  Widget _timelineRow(bool active, IconData icon, String time, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF1B5E20) : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onFailedPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[400],
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("THẤT BẠI",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onDeliveredPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B5E20),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(
                  8)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("ĐÃ GIAO",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

// =============================================
// MODEL ĐƠN ĐANG ĐẾN
// =============================================

class IncomingShipment {
  final String id, price, fromAddress, toAddress, recipientName, recipientPhone, status;

  IncomingShipment({
    required this.id,
    required this.price,
    required this.fromAddress,
    required this.toAddress,
    required this.recipientName,
    required this.recipientPhone,
    required this.status,
  });
}

// CARD ĐƠN ĐANG ĐẾN
class IncomingShipmentCard extends StatelessWidget {
  final IncomingShipment data;
  final VoidCallback onDecline;
  final VoidCallback onAccept;

  const IncomingShipmentCard({
    super.key,
    required this.data,
    required this.onDecline,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 12),
            _addresses(),
            const SizedBox(height: 14),
            _buttons(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.confirmation_number, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 6),
            const Text("Mã vận đơn", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        Text("${data.price} VNĐ",
            style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _addresses() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.fromAddress, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text("Tên người nhận: ${data.recipientName}",
                  style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.toAddress, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 3),
              Text("SĐT người nhận: ${data.recipientPhone}",
                  style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onDecline,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("TỪ CHỐI",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.red)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onAccept,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B5E20),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("CHẤP NHẬN",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
