import 'package:flutter/material.dart';
import '../../../../data/models/shipper/report_statistics_item.dart';
import 'reports_export_sheet.dart';

class ReportsStatisticScreen extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  const ReportsStatisticScreen({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<ReportsStatisticScreen> createState() => _ReportsStatisticScreenState();
}

class _ReportsStatisticScreenState extends State<ReportsStatisticScreen> {
  String selectedTab = "Tất cả";

  final List<ReportItem> allData = [
    ReportItem(orderId: "JK1245LM78", customerName: "Juan Dela Cruz", date: "Jul 14, 2024", status: "Delivered"),
    ReportItem(orderId: "AB5678XY90", customerName: "Maria Santos", date: "Jul 14, 2024", status: "Delivered"),
    ReportItem(orderId: "QR2345EF67", customerName: "Jose Garcia", date: "Jul 13, 2024", status: "Delivered"),
    ReportItem(orderId: "UV8901CD34", customerName: "Ana Reyes", date: "Jul 13, 2024", status: "Delivered"),
    ReportItem(orderId: "LM3456WX89", customerName: "Carlos Mendo...", date: "Jul 13, 2024", status: "Delivered"),
    ReportItem(orderId: "ST4567OP23", customerName: "Alberto Ramos", date: "Jul 12, 2024", status: "Unsuccessful"),
    ReportItem(orderId: "CD1234UV56", customerName: "Luisa Aquino", date: "Jul 12, 2024", status: "Delivered"),
    ReportItem(orderId: "GH7890IJ34", customerName: "Miguel Torres", date: "Jul 12, 2024", status: "Delivered"),
    ReportItem(orderId: "MN5678AB12", customerName: "Lourdes Villan...", date: "Jul 11, 2024", status: "Cancel"),
    ReportItem(orderId: "WX2345CD67", customerName: "Teresa Alonso", date: "Jul 11, 2024", status: "Delivered"),
    ReportItem(orderId: "QR9789EF12", customerName: "Nestor Diaz", date: "Jul 10, 2024", status: "Delivered"),
    ReportItem(orderId: "QR3456GH89", customerName: "Elisa Gomez", date: "Jul 9, 2024", status: "Delivered"),
    ReportItem(orderId: "PO1584IJ95", customerName: "Althea Reyes", date: "Jul 8, 2024", status: "Delivered"),
    ReportItem(orderId: "QR3456GH89", customerName: "Elisa Gomez", date: "Jul 7, 2024", status: "Unsuccessful"),
  ];

  List<ReportItem> get filteredData {
    if (selectedTab == "Tất cả") return allData;
    if (selectedTab == "Đã giao") {
      return allData.where((item) => item.status == "Delivered").toList();
    }
    return allData.where((item) => item.status == "Unsuccessful" || item.status == "Cancel").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Nhập ngày",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildDateRangeSection(),
          _buildTabs(),
          _buildDateRangeInfo(),
          _buildTableHeader(),
          Expanded(child: _buildTableContent()),
          _buildExportButton(),
        ],
      ),
    );
  }

  Widget _buildDateRangeSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildDateBox("Ngày bắt đầu", widget.startDate),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildDateBox("Ngày kết thúc", widget.endDate),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBox(String label, DateTime date) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = [
      {"label": "Tất cả", "value": "Tất cả"},
      {"label": "Đã giao", "value": "Đã giao"},
      {"label": "Không thành công", "value": "Không thành công"},
      {"label": "Hủy", "value": "Hủy"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab["value"];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = tab["value"]!),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFEB3B) : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tab["label"]!,
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? Colors.black87 : Colors.grey.shade600,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateRangeInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Báo cáo từ July 6, 2024 - July 14, 2024",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFFD7CCC8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Mã vận đơn",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Tên người nhận",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Ngày giao",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Trạng thái giao",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableContent() {
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];
        final isEven = index % 2 == 0;

        return Container(
          color: isEven ? Colors.white : const Color(0xFFF5F5F5),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  item.orderId,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  item.customerName,
                  style: const TextStyle(fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  item.date,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  item.status,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExportButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B5E20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => const ReportExportSheet(),
            );
          },
          child: const Text(
            "XUẤT FILE BÁO CÁO",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Report Export Bottom Sheet
class ReportExportSheet extends StatelessWidget {
  const ReportExportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.grey.shade700,
                  size: 24,
                ),
              ),
              title: const Text(
                "Gửi qua Gmail",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đang gửi qua Gmail...')),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(height: 1, color: Colors.grey.shade200),
            ),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: Colors.grey.shade700,
                  size: 24,
                ),
              ),
              title: const Text(
                "Xuất dưới dạng PDF",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đang xuất PDF...')),
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}