import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'daily_summary_screen.dart';
import 'income_summary_screen.dart';

class MonthlySummaryScreen extends StatefulWidget {
  const MonthlySummaryScreen({super.key});

  @override
  State<MonthlySummaryScreen> createState() => _MonthlySummaryScreenState();
}

class _MonthlySummaryScreenState extends State<MonthlySummaryScreen>
    with SingleTickerProviderStateMixin {

  static const double _horizontalPadding = 20.0;
  static const double _cardRadius = 16.0;
  static const double _smallCardRadius = 12.0;

  int _selectedPeriod = 2; // 0: Hôm nay, 1: 7 ngày, 2: 30 ngày
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Mock data
  final Map<String, dynamic> _monthlyData = {
    'revenue': 12350000,
    'completedOrders': 143,
    'failedOrders': 8,
    'totalOrders': 151,
    'successRate': 94.7,
    'avgPerOrder': 86363,
    'bestDay': 'Thứ 6',
    'topArea': 'Quận 1',
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  // ==================== SỬA ĐÚNG CHỖ NÀY ====================
  void _changePeriod(int index) {
    if (_selectedPeriod == index) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DailySummaryScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const IncomeSummaryScreen()),
      );
    } else {
      setState(() {
        _selectedPeriod = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPeriodSelector(),
                const SizedBox(height: 24),
                _buildMonthSelector(),
                const SizedBox(height: 24),
                _buildMainRevenueCard(),
                const SizedBox(height: 16),
                _buildOrdersGrid(),
                const SizedBox(height: 24),
                _buildPerformanceSection(),
                const SizedBox(height: 24),
                _buildInsightsSection(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========================= APP BAR =========================
  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: const Text(
          'Thống kê theo tháng',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blue.shade50.withOpacity(0.3),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.calendar_month, color: Colors.blue.shade700),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.download_outlined, color: Colors.blue.shade700),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đang xuất báo cáo tháng...')),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ===================== PERIOD SELECTOR =====================
  Widget _buildPeriodSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildPeriodTab('Hôm nay', 0, Icons.today_outlined),
          _buildPeriodTab('7 ngày', 1, Icons.date_range_outlined),
          _buildPeriodTab('30 ngày', 2, Icons.calendar_month_outlined),
        ],
      ),
    );
  }

  Widget _buildPeriodTab(String label, int index, IconData icon) {
    final isSelected = _selectedPeriod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _changePeriod(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade700 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.grey.shade600),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ====================== MONTH SELECTOR ======================
  Widget _buildMonthSelector() {
    final now = DateTime.now();

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_smallCardRadius),
          border: Border.all(color: Colors.blue.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.calendar_today, color: Colors.blue.shade700, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tháng hiện tại',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    'Tháng ${now.month}/${now.year}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  // ===================== MAIN REVENUE CARD =====================
  Widget _buildMainRevenueCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade800],
          ),
          borderRadius: BorderRadius.circular(_cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade700.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.account_balance_wallet_outlined,
                      color: Colors.white, size: 28),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text('+8%',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Tổng doanh thu tháng',
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
            const SizedBox(height: 8),
            Text(
              _formatCurrency(_monthlyData['revenue']),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.white.withOpacity(0.3)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildQuickStat(
                    'TB/đơn',
                    _formatCurrency(_monthlyData['avgPerOrder']),
                    Icons.trending_up_outlined,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildQuickStat(
                    'Ngày tốt nhất',
                    _monthlyData['bestDay'],
                    Icons.star_outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 20),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
      ],
    );
  }

  // ====================== GRID ORDER CARDS ======================
  Widget _buildOrdersGrid() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildOrderCard(
                    'Đơn thành công',
                    '${_monthlyData['completedOrders']}',
                    Icons.check_circle_outline,
                    Colors.green.shade600,
                    Colors.green.shade50,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOrderCard(
                    'Đơn thất bại',
                    '${_monthlyData['failedOrders']}',
                    Icons.cancel_outlined,
                    Colors.red.shade600,
                    Colors.red.shade50,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildOrderCard(
                    'Tổng số đơn',
                    '${_monthlyData['totalOrders']}',
                    Icons.local_shipping_outlined,
                    Colors.blue.shade600,
                    Colors.blue.shade50,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOrderCard(
                    'Tỷ lệ hoàn thành',
                    '${_monthlyData['successRate']}%',
                    Icons.verified_outlined,
                    Colors.orange.shade600,
                    Colors.orange.shade50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(
      String title, String value, IconData icon, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_smallCardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 14),
          Text(title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  // ====================== PERFORMANCE SECTION ======================
  Widget _buildPerformanceSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hiệu suất tháng',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_cardRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildPerformanceRow(
                    'Khu vực tốt nhất',
                    _monthlyData['topArea'],
                    Icons.location_on_outlined,
                    Colors.purple.shade600,
                  ),
                  const Divider(height: 24),
                  _buildPerformanceRow(
                    'Số ngày làm việc',
                    '26 ngày',
                    Icons.event_available_outlined,
                    Colors.teal.shade600,
                  ),
                  const Divider(height: 24),
                  _buildPerformanceRow(
                    'Thu nhập TB/ngày',
                    _formatCurrency(_monthlyData['revenue'] ~/ 26),
                    Icons.attach_money_outlined,
                    Colors.indigo.shade600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceRow(
      String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }

  // ======================== INSIGHTS ========================
  Widget _buildInsightsSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Đánh giá & Mục tiêu',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),

            _buildInsightCard(
              icon: Icons.emoji_events_outlined,
              iconColor: Colors.amber.shade600,
              iconBg: Colors.amber.shade50,
              title: 'Thành tích xuất sắc',
              description: 'Bạn đã hoàn thành 94.7% đơn hàng!',
            ),
            const SizedBox(height: 12),

            _buildInsightCard(
              icon: Icons.trending_up,
              iconColor: Colors.green.shade600,
              iconBg: Colors.green.shade50,
              title: 'Tăng trưởng ổn định',
              description: 'Thu nhập tháng này tăng 8% so với tháng trước.',
            ),
            const SizedBox(height: 12),

            _buildInsightCard(
              icon: Icons.lightbulb_outline,
              iconColor: Colors.blue.shade600,
              iconBg: Colors.blue.shade50,
              title: 'Gợi ý cải thiện',
              description: 'Tập trung vào khu vực Quận 1 để đạt kết quả tốt hơn.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_smallCardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    )),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
