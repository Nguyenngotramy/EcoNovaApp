import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'income_summary_screen.dart';
import 'monthly_summary_screen.dart';

class DailySummaryScreen extends StatefulWidget {
  const DailySummaryScreen({super.key});

  @override
  State<DailySummaryScreen> createState() => _DailySummaryScreenState();
}

class _DailySummaryScreenState extends State<DailySummaryScreen>
    with SingleTickerProviderStateMixin {

  static const double _horizontalPadding = 20.0;
  static const double _cardRadius = 16.0;
  static const double _smallCardRadius = 12.0;

  int _selectedPeriod = 0; // 0: Hôm nay, 1: 7 ngày, 2: 30 ngày
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Map<String, dynamic> _dailyData = {
    'revenue': 520000,
    'completedOrders': 12,
    'failedOrders': 1,
    'totalOrders': 13,
    'successRate': 92.3,
    'avgPerOrder': 43333,
    'workingHours': 8.5,
    'peakHour': '11:00',
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

  // ==================== FIX CHUYỂN TAB ====================
  void _changePeriod(int index) {
    if (_selectedPeriod == index) return;

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const IncomeSummaryScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MonthlySummaryScreen()),
      );
    } else {
      setState(() {
        _selectedPeriod = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }
  // ========================================================

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
                _buildDateCard(),
                const SizedBox(height: 24),
                _buildMainRevenueCard(),
                const SizedBox(height: 16),
                _buildOrdersGrid(),
                const SizedBox(height: 24),
                _buildHourlyBreakdown(),
                const SizedBox(height: 24),
                _buildTodayInsights(),
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
          'Thống kê hôm nay',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.orange.shade50.withOpacity(0.4),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh, color: Colors.orange.shade700),
          onPressed: () {
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đã làm mới dữ liệu')),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.download_outlined, color: Colors.orange.shade700),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Xuất báo cáo hôm nay...')),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ========================= PERIOD SELECTOR =========================

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
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange.shade700 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.grey.shade700),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================= DATE CARD =========================

  Widget _buildDateCard() {
    final now = DateTime.now();
    final dayOfWeek = DateFormat('EEEE', 'vi_VN').format(now);
    final date = DateFormat('dd/MM/yyyy').format(now);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.orange.shade50,
            Colors.orange.shade100
          ]),
          borderRadius: BorderRadius.circular(_cardRadius),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.calendar_today, color: Colors.orange.shade700, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dayOfWeek,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange.shade900)),
                    Text(date,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.orange.shade900)),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text('${_dailyData['workingHours']}h',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================= MAIN REVENUE CARD =========================

  Widget _buildMainRevenueCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade600,
              Colors.orange.shade700,
            ],
          ),
          borderRadius: BorderRadius.circular(_cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade600.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
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
                        color: Colors.white, size: 26)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Hôm nay",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text("Tổng doanh thu",
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 4),
            Text(_formatCurrency(_dailyData['revenue']),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 16),
            Divider(color: Colors.white.withOpacity(0.3)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildQuickStat("TB/đơn",
                        _formatCurrency(_dailyData['avgPerOrder']),
                        Icons.monetization_on_outlined)),
                Container(width: 1, height: 40, color: Colors.white24),
                Expanded(
                    child: _buildQuickStat(
                        "Giờ cao điểm",
                        _dailyData['peakHour'],
                        Icons.schedule_outlined)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.white70),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14))
      ],
    );
  }

  // ========================= ORDERS GRID =========================

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
                    child: _buildOrderCard("Đơn thành công",
                        '${_dailyData['completedOrders']}',
                        Icons.check_circle_outline,
                        Colors.green.shade600,
                        Colors.green.shade50)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildOrderCard("Đơn thất bại",
                        '${_dailyData['failedOrders']}',
                        Icons.cancel_outlined,
                        Colors.red.shade600,
                        Colors.red.shade50)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: _buildOrderCard("Tổng đơn hàng",
                        '${_dailyData['totalOrders']}',
                        Icons.local_shipping_outlined,
                        Colors.blue.shade600,
                        Colors.blue.shade50)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildOrderCard("Tỷ lệ thành công",
                        '${_dailyData['successRate']}%',
                        Icons.verified_outlined,
                        Colors.purple.shade600,
                        Colors.purple.shade50)),
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
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration:
              BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 24, color: color)),
          const SizedBox(height: 14),
          Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // ========================= HOURLY BREAKDOWN =========================

  Widget _buildHourlyBreakdown() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Phân bổ theo giờ",
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
                  ]),
              child: Column(
                children: [
                  _buildHourlyRow("08:00 - 10:00", 3, 180000, 0.3),
                  const SizedBox(height: 16),
                  _buildHourlyRow("10:00 - 12:00", 5, 230000, 0.5),
                  const SizedBox(height: 16),
                  _buildHourlyRow("12:00 - 14:00", 2, 65000, 0.2),
                  const SizedBox(height: 16),
                  _buildHourlyRow("14:00 - 17:00", 2, 45000, 0.15),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyRow(
      String time, int orders, int revenue, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700),
                ),
              ],
            ),
            Text(
              '$orders đơn • ${_formatCurrency(revenue)}',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation(Colors.yellow.shade600),
          ),
        ),
      ],
    );
  }

  // ========================= INSIGHTS =========================

  Widget _buildTodayInsights() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nhận xét hôm nay",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),

            _buildInsightCard(
              icon: Icons.emoji_events_outlined,
              iconColor: Colors.amber.shade600,
              iconBg: Colors.amber.shade50,
              title: "Ngày làm việc tốt",
              description:
              "Bạn đã hoàn thành 92.3% đơn hàng hôm nay. Xuất sắc!",
            ),
            const SizedBox(height: 12),

            _buildInsightCard(
              icon: Icons.schedule,
              iconColor: Colors.blue.shade600,
              iconBg: Colors.blue.shade50,
              title: "Giờ vàng 10h-12h",
              description:
              "Khung giờ này mang lại nhiều đơn và thu nhập nhất.",
            ),
            const SizedBox(height: 12),

            _buildInsightCard(
              icon: Icons.lightbulb_outline,
              iconColor: Colors.green.shade600,
              iconBg: Colors.green.shade50,
              title: "Gợi ý",
              description:
              "Hãy tập trung vào buổi sáng để tối ưu hiệu quả làm việc.",
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
          ]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(description,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          height: 1.4)),
                ],
              ))
        ],
      ),
    );
  }
}
