import 'package:flutter/material.dart';

class AIManagementScreen extends StatefulWidget {
  const AIManagementScreen({Key? key}) : super(key: key);

  @override
  State<AIManagementScreen> createState() => _AIManagementScreenState();
}

class _AIManagementScreenState extends State<AIManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: _currentTabIndex);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() => _currentTabIndex = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          'Quản lý AI',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF043915)),
            onPressed: () {
              // TODO: Refresh all AI data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã làm mới dữ liệu AI')),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF043915)),
            onSelected: (value) {
              if (value == 'settings') {
                // TODO: Navigate to AI settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cài đặt AI...')),
                );
              } else if (value == 'logs') {
                // TODO: View AI logs
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Xem log AI...')),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'settings', child: Text('Cài đặt AI')),
              const PopupMenuItem(value: 'logs', child: Text('Xem log AI')),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) => _tabController.animateTo(index),
          labelColor: const Color(0xFF043915),
          unselectedLabelColor: const Color(0xFF999999),
          indicatorColor: const Color(0xFF043915),
          labelStyle: const TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Chat AI'),
            Tab(text: 'Gợi ý Sản phẩm'),
            Tab(text: 'Dự đoán Giá'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ChatAIManagementWidget(),
          _RecommendationAIManagementWidget(),
          _PricePredictionAIManagementWidget(),
        ],
      ),
    );
  }
}

// Tab 1: Quản lý Chat AI
class _ChatAIManagementWidget extends StatefulWidget {
  @override
  State<_ChatAIManagementWidget> createState() => _ChatAIManagementWidgetState();
}

class _ChatAIManagementWidgetState extends State<_ChatAIManagementWidget> {
  String _selectedStatus = 'Tất cả';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and Filter
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm cuộc trò chuyện...',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF666666)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Tất cả'),
                    _buildFilterChip('Đang hoạt động'),
                    _buildFilterChip('Kết thúc'),
                    _buildFilterChip('Có vấn đề'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Stats
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('Cuộc trò chuyện', '1,234', Icons.chat_bubble_outline),
              _buildStatCard('Người dùng hoạt động', '567', Icons.people),
              _buildStatCard('Phản hồi AI', '89%', Icons.thumb_up),
            ],
          ),
        ),
        // List of Chats
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 10,
            itemBuilder: (context, index) {
              return _ChatCardWidget(
                userName: 'User ${index + 1}',
                lastMessage: 'Câu hỏi về sản phẩm...',
                status: index % 3 == 0 ? 'Đang hoạt động' : 'Kết thúc',
                responseTime: '${index + 1}s',
                onView: () => print('View chat $index'),
                onDelete: () => print('Delete chat $index'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedStatus == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => setState(() => _selectedStatus = label),
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
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF043915), size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Be Vietnam Pro',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF043915),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Be Vietnam Pro',
                fontSize: 11,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatCardWidget extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String status;
  final String responseTime;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const _ChatCardWidget({
    required this.userName,
    required this.lastMessage,
    required this.status,
    required this.responseTime,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'Đang hoạt động' ? const Color(0xFF043915) : const Color(0xFF666666);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF043915).withOpacity(0.1),
            child: const Icon(Icons.person, color: Color(0xFF043915)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF043915),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.speed, size: 12, color: const Color(0xFF666666)),
                    const SizedBox(width: 4),
                    Text(
                      'Phản hồi: $responseTime',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 10,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ],
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
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF043915)),
            onSelected: (value) {
              if (value == 'view') onView();
              if (value == 'delete') onDelete();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'view', child: Text('Xem chi tiết')),
              const PopupMenuItem(value: 'delete', child: Text('Xóa')),
            ],
          ),
        ],
      ),
    );
  }
}

// Tab 2: Gợi ý Sản phẩm AI
class _RecommendationAIManagementWidget extends StatefulWidget {
  @override
  State<_RecommendationAIManagementWidget> createState() => _RecommendationAIManagementWidgetState();
}

class _RecommendationAIManagementWidgetState extends State<_RecommendationAIManagementWidget> {
  String _selectedCategory = 'Tất cả';
  String _searchQuery = '';
  bool _showApprovedOnly = false;
  final TextEditingController _searchController = TextEditingController();

  // Mock data
  final List<RecommendationModel> _recommendations = [
    RecommendationModel(
      id: 1,
      productName: 'iPhone 15 Pro Max',
      category: 'Điện thoại',
      confidenceScore: 0.92,
      predictedSales: '1,200 đơn',
      status: RecommendationStatus.pending,
    ),
    RecommendationModel(
      id: 2,
      productName: 'MacBook Air M3',
      category: 'Laptop',
      confidenceScore: 0.87,
      predictedSales: '850 đơn',
      status: RecommendationStatus.approved,
    ),
    RecommendationModel(
      id: 3,
      productName: 'AirPods Pro 2',
      category: 'Phụ kiện',
      confidenceScore: 0.78,
      predictedSales: '950 đơn',
      status: RecommendationStatus.rejected,
    ),
    RecommendationModel(
      id: 4,
      productName: 'Samsung Galaxy S24',
      category: 'Điện thoại',
      confidenceScore: 0.95,
      predictedSales: '1,500 đơn',
      status: RecommendationStatus.pending,
    ),
  ];

  List<RecommendationModel> get _filteredRecommendations {
    return _recommendations.where((rec) {
      final matchesSearch = _searchQuery.isEmpty ||
          rec.productName.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Tất cả' || rec.category == _selectedCategory;
      final matchesStatus = !_showApprovedOnly || rec.status == RecommendationStatus.approved;
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sản phẩm...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFF666666)),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Color(0xFF666666)),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        // Filters
        _CategoryFilterWidget(
          selectedCategory: _selectedCategory,
          onCategoryChanged: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
        ),
        // Status Toggle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text(
                    'Chỉ hiển thị đã duyệt',
                    style: TextStyle(
                      fontFamily: 'Be Vietnam Pro',
                      fontSize: 14,
                      color: Color(0xFF043915),
                    ),
                  ),
                  value: _showApprovedOnly,
                  onChanged: (value) {
                    setState(() {
                      _showApprovedOnly = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: const Color(0xFF043915),
                ),
              ),
            ],
          ),
        ),
        // Stats Summary
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('Tổng gợi ý', '${_recommendations.length}', Icons.list_alt),
              _buildStatCard('Đã duyệt', '${_recommendations.where((r) => r.status == RecommendationStatus.approved).length}', Icons.check_circle),
              _buildStatCard('Chờ duyệt', '${_recommendations.where((r) => r.status == RecommendationStatus.pending).length}', Icons.pending),
              _buildStatCard('Từ chối', '${_recommendations.where((r) => r.status == RecommendationStatus.rejected).length}', Icons.cancel),
            ],
          ),
        ),
        // List of Recommendations
        Expanded(
          child: _RecommendationListWidget(
            recommendations: _filteredRecommendations,
            onStatusChanged: (id, newStatus) {
              setState(() {
                final rec = _recommendations.firstWhere((r) => r.id == id);
                rec.status = newStatus;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã cập nhật trạng thái cho gợi ý ${id}')),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF043915), size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Be Vietnam Pro',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF043915),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Be Vietnam Pro',
                fontSize: 11,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// _CategoryFilterWidget (reused)
class _CategoryFilterWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const _CategoryFilterWidget({
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('Tất cả'),
            const SizedBox(width: 8),
            _buildFilterChip('Điện thoại'),
            const SizedBox(width: 8),
            _buildFilterChip('Laptop'),
            const SizedBox(width: 8),
            _buildFilterChip('Phụ kiện'),
            const SizedBox(width: 8),
            _buildFilterChip('Nhà cửa'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedCategory == label;
    return InkWell(
      onTap: () => onCategoryChanged(label),
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

// _RecommendationListWidget (reused)
class _RecommendationListWidget extends StatelessWidget {
  final List<RecommendationModel> recommendations;
  final Function(int, RecommendationStatus) onStatusChanged;

  const _RecommendationListWidget({
    required this.recommendations,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return const Center(
        child: Text(
          'Không có gợi ý nào phù hợp',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: recommendations.length,
      itemBuilder: (context, index) {
        final rec = recommendations[index];
        return _RecommendationCardWidget(
          model: rec,
          onApprove: () => onStatusChanged(rec.id, RecommendationStatus.approved),
          onReject: () => onStatusChanged(rec.id, RecommendationStatus.rejected),
        );
      },
    );
  }
}

// _RecommendationCardWidget (reused)
class _RecommendationCardWidget extends StatelessWidget {
  final RecommendationModel model;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _RecommendationCardWidget({
    required this.model,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(model.status);
    IconData statusIcon = _getStatusIcon(model.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image Placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: Color(0xFFE0E0E0), size: 40),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.productName,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF043915),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF043915).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    model.category,
                    style: const TextStyle(
                      fontFamily: 'Be Vietnam Pro',
                      fontSize: 12,
                      color: Color(0xFF043915),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.insights_outlined, size: 14, color: const Color(0xFF666666)),
                    const SizedBox(width: 4),
                    Text(
                      'Độ tin cậy: ${(model.confidenceScore * 100).toInt()}%',
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 10,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.trending_up, size: 14, color: const Color(0xFF666666)),
                    const SizedBox(width: 4),
                    Text(
                      'Dự đoán bán: ${model.predictedSales}',
                      style: const TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 10,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 14, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        _getStatusText(model.status),
                        style: TextStyle(
                          fontFamily: 'Be Vietnam Pro',
                          fontSize: 11,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Actions
          if (model.status == RecommendationStatus.pending) ...[
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.check_circle_outline, color: Color(0xFF043915), size: 28),
                  onPressed: onApprove,
                  tooltip: 'Duyệt gợi ý',
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: const Icon(Icons.cancel_outlined, color: Color(0xFFE53935), size: 28),
                  onPressed: onReject,
                  tooltip: 'Từ chối gợi ý',
                ),
              ],
            ),
          ] else ...[
            IconButton(
              icon: Icon(statusIcon, color: statusColor, size: 28),
              onPressed: () {}, // Disabled for non-pending
              tooltip: _getStatusText(model.status),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(RecommendationStatus status) {
    switch (status) {
      case RecommendationStatus.approved:
        return const Color(0xFF043915);
      case RecommendationStatus.rejected:
        return const Color(0xFFE53935);
      case RecommendationStatus.pending:
        return const Color(0xFFFF9800);
    }
  }

  IconData _getStatusIcon(RecommendationStatus status) {
    switch (status) {
      case RecommendationStatus.approved:
        return Icons.check_circle;
      case RecommendationStatus.rejected:
        return Icons.cancel;
      case RecommendationStatus.pending:
        return Icons.pending;
    }
  }

  String _getStatusText(RecommendationStatus status) {
    switch (status) {
      case RecommendationStatus.approved:
        return 'Đã duyệt';
      case RecommendationStatus.rejected:
        return 'Đã từ chối';
      case RecommendationStatus.pending:
        return 'Chờ duyệt';
    }
  }
}

// Tab 3: Dự đoán Giá cả AI
class _PricePredictionAIManagementWidget extends StatefulWidget {
  @override
  State<_PricePredictionAIManagementWidget> createState() => _PricePredictionAIManagementWidgetState();
}

class _PricePredictionAIManagementWidgetState extends State<_PricePredictionAIManagementWidget> {
  String _selectedProduct = 'Tất cả';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and Filter
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF666666)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Tất cả'),
                    _buildFilterChip('Điện thoại'),
                    _buildFilterChip('Laptop'),
                    _buildFilterChip('Phụ kiện'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Stats
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('Dự đoán chính xác', '92%', Icons.analytics),
              _buildStatCard('Sản phẩm theo dõi', '456', Icons.inventory_2),
              _buildStatCard('Cập nhật gần nhất', '2h trước', Icons.update),
            ],
          ),
        ),
        // List of Predictions
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 10,
            itemBuilder: (context, index) {
              return _PricePredictionCardWidget(
                productName: 'Sản phẩm ${index + 1}',
                currentPrice: '${(1000000 + index * 50000).toStringAsFixed(0)}đ',
                predictedPrice: '${(950000 + index * 45000).toStringAsFixed(0)}đ',
                change: (index % 2 == 0 ? '+' : '-') + '${index * 5}%',
                confidence: 0.85 + (index * 0.02),
                onUpdate: () => print('Update prediction $index'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedProduct == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => setState(() => _selectedProduct = label),
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
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF043915), size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Be Vietnam Pro',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF043915),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Be Vietnam Pro',
                fontSize: 11,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PricePredictionCardWidget extends StatelessWidget {
  final String productName;
  final String currentPrice;
  final String predictedPrice;
  final String change;
  final double confidence;
  final VoidCallback onUpdate;

  const _PricePredictionCardWidget({
    required this.productName,
    required this.currentPrice,
    required this.predictedPrice,
    required this.change,
    required this.confidence,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    Color changeColor = change.startsWith('+') ? const Color(0xFF043915) : const Color(0xFFE53935);

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
              Expanded(
                child: Text(
                  productName,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF043915),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF043915).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${(confidence * 100).toInt()}% tin cậy',
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    fontSize: 10,
                    color: Color(0xFF043915),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.price_change, size: 14, color: Color(0xFF666666)),
              const SizedBox(width: 4),
              Text(
                'Hiện tại: $currentPrice',
                style: const TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.trending_up, size: 14, color: changeColor),
              const SizedBox(width: 4),
              Text(
                'Dự đoán: $predictedPrice ($change)',
                style: TextStyle(
                  fontFamily: 'Be Vietnam Pro',
                  fontSize: 12,
                  color: changeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onUpdate,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Cập nhật dự đoán'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF043915),
                    side: const BorderSide(color: Color(0xFF043915)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

// Models
enum RecommendationStatus { pending, approved, rejected }

class RecommendationModel {
  final int id;
  final String productName;
  final String category;
  final double confidenceScore;
  final String predictedSales;
  RecommendationStatus status;

  RecommendationModel({
    required this.id,
    required this.productName,
    required this.category,
    required this.confidenceScore,
    required this.predictedSales,
    this.status = RecommendationStatus.pending,
  });
}