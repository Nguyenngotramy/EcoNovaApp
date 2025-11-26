import 'package:flutter/material.dart';

class RevenueStatisticsScreen extends StatefulWidget {
  const RevenueStatisticsScreen({Key? key}) : super(key: key);

  @override
  State<RevenueStatisticsScreen> createState() => _RevenueStatisticsScreenState();
}

class _RevenueStatisticsScreenState extends State<RevenueStatisticsScreen> {
  String _selectedPeriod = 'Tháng này';

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
          'Thống kê doanh thu',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFF043915)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _RevenuePeriodFilterWidget(
            selectedPeriod: _selectedPeriod,
            onPeriodChanged: (period) {
              setState(() {
                _selectedPeriod = period;
              });
            },
          ),
          _RevenueSummaryWidget(),
          const SizedBox(height: 16),
          Expanded(
            child: _RevenueChartWidget(),
          ),
        ],
      ),
    );
  }
}

class _RevenuePeriodFilterWidget extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const _RevenuePeriodFilterWidget({
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildChip('Hôm nay'),
          const SizedBox(width: 8),
          _buildChip('Tuần này'),
          const SizedBox(width: 8),
          _buildChip('Tháng này'),
          const SizedBox(width: 8),
          _buildChip('Năm nay'),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    final isSelected = selectedPeriod == label;
    return Expanded(
      child: InkWell(
        onTap: () => onPeriodChanged(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF043915) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF043915) : const Color(0xFFE0E0E0),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 11,
              color: isSelected ? Colors.white : const Color(0xFF666666),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _RevenueSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Tổng doanh thu',
                  '23.5M',
                  Icons.attach_money,
                  const Color(0xFF043915),
                  '+12%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Đơn hàng',
                  '567',
                  Icons.shopping_bag_outlined,
                  const Color(0xFF4C763B),
                  '+8%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Trung bình/đơn',
                  '41.4K',
                  Icons.trending_up,
                  const Color(0xFFFF9800),
                  '+3%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Hoàn thành',
                  '523',
                  Icons.check_circle_outline,
                  const Color(0xFF043915),
                  '+15%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
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
              Icon(icon, color: color, size: 20),
              Text(
                change,
                style: TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF043915),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 11,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueChartWidget extends StatelessWidget {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Biểu đồ doanh thu',
            style: TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF043915),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                double height = 50 + (index * 20) % 150;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${(height / 10).toInt()}M',
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 10,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 30,
                      height: height,
                      decoration: BoxDecoration(
                        color: const Color(0xFF043915),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'T${index + 1}',
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 11,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}