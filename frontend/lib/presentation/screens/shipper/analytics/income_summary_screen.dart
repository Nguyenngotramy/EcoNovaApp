import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'daily_summary_screen.dart';
import 'monthly_summary_screen.dart';

class IncomeSummaryScreen extends StatefulWidget {
  const IncomeSummaryScreen({super.key});

  @override
  State<IncomeSummaryScreen> createState() => _IncomeSummaryScreenState();
}

class _IncomeSummaryScreenState extends State<IncomeSummaryScreen>
    with SingleTickerProviderStateMixin {
  static const double _horizontalPadding = 20.0;
  static const double _cardRadius = 16.0;
  static const double _smallCardRadius = 12.0;

  int _selectedPeriod = 1; // 0: Hôm nay, 1: 7 ngày, 2: 30 ngày
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Map<int, Map<String, dynamic>> _periodData = {
    0: {
      'income': 185000,
      'orders': 8,
      'successRate': 100,
      'avgPerOrder': 23125,
      'peakHour': '10:00 - 11:00',
    },
    1: {
      'income': 1250000,
      'orders': 32,
      'successRate': 94,
      'avgPerOrder': 39062,
      'peakHour': '09:00 - 12:00',
    },
    2: {
      'income': 4850000,
      'orders': 128,
      'successRate': 92,
      'avgPerOrder': 37890,
      'peakHour': '09:00 - 12:00',
    },
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

  Map<String, dynamic> get _currentData => _periodData[_selectedPeriod]!;

  // =============================== FIXED HERE ===============================
  void _changePeriod(int index) {
    if (_selectedPeriod == index) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DailySummaryScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MonthlySummaryScreen()),
      );
    } else {
      // 7 ngày
      setState(() {
        _selectedPeriod = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }
  // ==========================================================================

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
                _buildMainIncomeCard(),
                const SizedBox(height: 16),
                _buildStatsGrid(),
                const SizedBox(height: 24),
                _buildChartSection(),
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

  // =============================== APP BAR ===============================
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
          'Thống kê thu nhập',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.download_outlined, color: Colors.green.shade700),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đang xuất báo cáo...')),
            );
          },
        ),
      ],
    );
  }

  // ============================ PERIOD SELECTOR ============================
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
    final selected = _selectedPeriod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _changePeriod(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.green.shade700 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18, color: selected ? Colors.white : Colors.grey),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================== MAIN INCOME CARD ===========================
  Widget _buildMainIncomeCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade800],
          ),
          borderRadius: BorderRadius.circular(_cardRadius),
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.trending_up,
                          color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '+12%',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Tổng thu nhập',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9), fontSize: 14)),
            const SizedBox(height: 8),
            Text(
              _formatCurrency(_currentData['income']),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildQuickStat(
                    'TB/đơn',
                    _formatCurrency(_currentData['avgPerOrder']),
                    Icons.show_chart,
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.white30),
                Expanded(
                  child: _buildQuickStat(
                    'Giờ cao điểm',
                    _currentData['peakHour'],
                    Icons.schedule,
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
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(value,
            style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ],
    );
  }

  // =============================== STATS GRID ===============================
  Widget _buildStatsGrid() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Số đơn hàng',
                '${_currentData['orders']}',
                Icons.local_shipping_outlined,
                Colors.blue.shade600,
                Colors.blue.shade50,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Hoàn thành',
                '${_currentData['successRate']}%',
                Icons.verified_outlined,
                Colors.orange.shade600,
                Colors.orange.shade50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_smallCardRadius),
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  // =============================== CHART SECTION ===============================
  Widget _buildChartSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Biểu đồ thu nhập',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.fullscreen,
                      color: Colors.green.shade700, size: 18),
                  label: Text('Xem chi tiết',
                      style: TextStyle(color: Colors.green.shade700)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 260,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_cardRadius),
                boxShadow: [
                  BoxShadow(color: Colors.black12.withOpacity(0.05)),
                ],
              ),
              child: Center(
                child: Text("Biểu đồ demo (sẽ thay bằng fl_chart)"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================== INSIGHTS ===============================
  Widget _buildInsightsSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Phân tích & Gợi ý',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            _buildInsight(
              icon: Icons.lightbulb_outline,
              iconColor: Colors.amber.shade600,
              bg: Colors.amber.shade50,
              title: 'Giờ cao điểm',
              desc:
              'Thu nhập cao nhất từ 9h-12h. Hãy ưu tiên nhận đơn trong khung giờ này.',
            ),
            const SizedBox(height: 12),
            _buildInsight(
              icon: Icons.trending_up,
              iconColor: Colors.green.shade600,
              bg: Colors.green.shade50,
              title: 'Tăng trưởng tốt',
              desc: 'Thu nhập tăng 12% so với kỳ trước. Hãy duy trì phong độ!',
            ),
            const SizedBox(height: 12),
            _buildInsight(
              icon: Icons.emoji_events_outlined,
              iconColor: Colors.purple.shade600,
              bg: Colors.purple.shade50,
              title: 'Mục tiêu tháng',
              desc: 'Bạn đã hoàn thành 68% mục tiêu tháng. Còn 1.5 triệu nữa!',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsight({
    required IconData icon,
    required Color iconColor,
    required Color bg,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_smallCardRadius),
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(0.05)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(desc,
                    style: TextStyle(color: Colors.grey.shade600, height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
