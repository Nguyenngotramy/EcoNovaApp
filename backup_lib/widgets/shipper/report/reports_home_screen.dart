import 'package:flutter/material.dart';
import '../data/report_item_model.dart';
import 'reports_date_picker.dart';
import '../notifications/notification_list_screen.dart';
import '../analytics/income_summary_screen.dart';


class ReportsHomeScreen extends StatefulWidget {
  const ReportsHomeScreen({super.key});

  @override
  State<ReportsHomeScreen> createState() => _ReportsHomeScreenState();
}

class _ReportsHomeScreenState extends State<ReportsHomeScreen> {
  String selectedTab = "Tất cả";

  final List<ReportItem> allOrders = [
    ReportItem(
      orderId: "AB1234XY78",
      customerName: "14 Phan Thanh...",
      receiverName: "1049 Ngô Quyền...",
      sendTime: "05/11/2025 8:29PM",
      receiveTime: "07/11/2025 9:12AM",
      status: "Đã giao",
      fee: "25.000 VND",
    ),
    ReportItem(
      orderId: "AB1234XY78",
      customerName: "14 Phan Thanh...",
      receiverName: "1049 Ngô Quyền...",
      sendTime: "05/11/2025 8:29PM",
      receiveTime: "07/11/2025 9:12AM",
      status: "Hủy giao",
      fee: "25.000 VND",
    ),
    ReportItem(
      orderId: "AB1234XY78",
      customerName: "14 Phan Thanh...",
      receiverName: "1049 Ngô Quyền...",
      sendTime: "05/11/2025 8:29PM",
      receiveTime: "07/11/2025 9:12AM",
      status: "Hủy giao",
      fee: "25.000 VND",
    ),
  ];

  List<ReportItem> get filteredOrders {
    if (selectedTab == "Tất cả") return allOrders;
    if (selectedTab == "Đã giao") {
      return allOrders.where((order) => order.status == "Đã giao").toList();
    }
    if (selectedTab == "Không thành công") {
      return allOrders.where((order) => order.status != "Đã giao").toList();
    }
    return allOrders.where((order) => order.status == "Hủy giao").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDateAndTabsSection(),
          const SizedBox(height: 12),
          Expanded(
            child: _buildOrderList(),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  //  APP BAR
  // ----------------------------------------------------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.amber.shade200,
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          const Text(
            "Xin chào, Diệu Linh!",
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
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
          icon: const Icon(Icons.insert_chart_outlined, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const IncomeSummaryScreen()),
            );
          },
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // HEADER SEARCH
  // ----------------------------------------------------------
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Báo Cáo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: "Tìm kiếm mã vận đơn",
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // DATE + FILTER TABS
  // ----------------------------------------------------------
  Widget _buildDateAndTabsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Các đơn gần đây",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReportsDatePickerScreen()),
                  );
                },
                icon: const Icon(Icons.calendar_today, size: 16),
                label: const Text("Chọn ngày"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black87,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),
        _buildTabs(),
      ],
    );
  }

  // ----------------------------------------------------------
  // FILTER TABS
  // ----------------------------------------------------------
  Widget _buildTabs() {
    final tabs = [
      "Tất cả",
      "Đã giao",
      "Không thành công",
      "Hủy giao",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFEB3B) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? Colors.black87 : Colors.grey.shade600,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ----------------------------------------------------------
  // LIST
  // ----------------------------------------------------------
  Widget _buildOrderList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(filteredOrders[index]);
      },
    );
  }

  // ----------------------------------------------------------
  // ORDER CARD
  // ----------------------------------------------------------
  Widget _buildOrderCard(ReportItem order) {
    final isDelivered = order.status == "Đã giao";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _orderHeader(order, isDelivered),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _orderDetailSection(order),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _feeRow(order),
          const SizedBox(height: 12),
          _detailButton(),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // ORDER HEADER
  // ----------------------------------------------------------
  Widget _orderHeader(ReportItem order, bool isDelivered) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.local_shipping_outlined, size: 20, color: Colors.grey.shade600),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Mã vận đơn", style: TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 2),
              Text(order.orderId,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isDelivered ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            order.status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDelivered ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
            ),
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // ORDER DETAIL SECTION
  // ----------------------------------------------------------
  Widget _orderDetailSection(ReportItem order) {
    return Row(
      children: [
        Expanded(
          child: _locationColumn(order.customerName, "Thời gian gửi", order.sendTime),
        ),
        Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade400),
        const SizedBox(width: 8),
        Expanded(
          child: _locationColumn(order.receiverName, "Thời gian nhận", order.receiveTime),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // TWO-COLUMN LOCATION UI
  // ----------------------------------------------------------
  Widget _locationColumn(String name, String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        Text(time,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  // ----------------------------------------------------------
  // FEE ROW
  // ----------------------------------------------------------
  Widget _feeRow(ReportItem order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Phí giao hàng",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        Text(order.fee,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // ----------------------------------------------------------
  // DETAIL BUTTON
  // ----------------------------------------------------------
  Widget _detailButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B5E20),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: const Text(
          "XEM CHI TIẾT",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
