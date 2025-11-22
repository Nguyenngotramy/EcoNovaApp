import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  State<InventoryManagementScreen> createState() => _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mock data
  final List<Map<String, dynamic>> _allProducts = [
    {
      'id': '1',
      'name': 'Cà chua cherry',
      'image': 'https://via.placeholder.com/150',
      'currentStock': 50,
      'minStock': 20,
      'unit': 'kg',
      'price': 40000,
      'status': 'good',
    },
    {
      'id': '2',
      'name': 'Xà lách xanh',
      'image': 'https://via.placeholder.com/150',
      'currentStock': 30,
      'minStock': 25,
      'unit': 'kg',
      'price': 25000,
      'status': 'warning',
    },
    {
      'id': '3',
      'name': 'Cà rốt baby',
      'image': 'https://via.placeholder.com/150',
      'currentStock': 5,
      'minStock': 15,
      'unit': 'kg',
      'price': 35000,
      'status': 'low',
    },
    {
      'id': '4',
      'name': 'Súp lơ xanh',
      'image': 'https://via.placeholder.com/150',
      'currentStock': 0,
      'minStock': 10,
      'unit': 'kg',
      'price': 45000,
      'status': 'out',
    },
    {
      'id': '5',
      'name': 'Cải bó xôi',
      'image': 'https://via.placeholder.com/150',
      'currentStock': 40,
      'minStock': 20,
      'unit': 'kg',
      'price': 20000,
      'status': 'good',
    },
  ];

  List<Map<String, dynamic>> get _lowStockProducts => 
    _allProducts.where((p) => p['status'] == 'low' || p['status'] == 'warning').toList();

  List<Map<String, dynamic>> get _outOfStockProducts => 
    _allProducts.where((p) => p['status'] == 'out').toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'good':
        return AppTheme.successColor;
      case 'warning':
        return AppTheme.warningColor;
      case 'low':
        return Colors.orange;
      case 'out':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'good':
        return 'Đủ hàng';
      case 'warning':
        return 'Sắp hết';
      case 'low':
        return 'Tồn kho thấp';
      case 'out':
        return 'Hết hàng';
      default:
        return '';
    }
  }

  void _showUpdateStockDialog(Map<String, dynamic> product) {
    final TextEditingController quantityController = TextEditingController();
    String? action = 'add'; // 'add' or 'remove'

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Cập nhật tồn kho', style: AppTheme.heading3),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['name'],
                style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Hiện có: ${product['currentStock']} ${product['unit']}',
                style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Nhập thêm', style: AppTheme.bodySmall),
                      value: 'add',
                      groupValue: action,
                      onChanged: (value) {
                        setState(() => action = value);
                      },
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      activeColor: AppTheme.primary,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Xuất kho', style: AppTheme.bodySmall),
                      value: 'remove',
                      groupValue: action,
                      onChanged: (value) {
                        setState(() => action = value);
                      },
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      activeColor: AppTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Số lượng',
                  hintText: 'Nhập số lượng',
                  suffixText: product['unit'],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle update stock
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cập nhật tồn kho thành công!'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              },
              child: const Text('Cập nhật'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cardBackground,
      appBar: AppBar(
        title: const Text('Quản lý kho', style: AppTheme.heading3),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primary,
          unselectedLabelColor: AppTheme.textLight,
          indicatorColor: AppTheme.primary,
          labelStyle: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: AppTheme.bodyMedium,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(  // Fix: Wrap Text để fit và tránh overflow
                    child: const Text(
                      'Tất cả',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),  // Fix: Giảm padding từ 6 xuống 4
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_allProducts.length}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(  // Fix: Wrap Text để fit và tránh overflow
                    child: const Text(
                      'Sắp hết',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (_lowStockProducts.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),  // Fix: Giảm padding
                      decoration: BoxDecoration(
                        color: AppTheme.warningColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_lowStockProducts.length}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(  // Fix: Wrap Text để fit và tránh overflow
                    child: const Text(
                      'Hết hàng',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (_outOfStockProducts.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),  // Fix: Giảm padding
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_outOfStockProducts.length}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProductList(_allProducts),
          _buildProductList(_lowStockProducts),
          _buildProductList(_outOfStockProducts),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Export inventory report
        },
        icon: const Icon(Icons.file_download),
        label: const Text('Xuất báo cáo'),
      ),
    );
  }

  Widget _buildProductList(List<Map<String, dynamic>> products) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: AppTheme.textLight.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Không có sản phẩm',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textLight,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildInventoryCard(product);
      },
    );
  }

  Widget _buildInventoryCard(Map<String, dynamic> product) {
    final status = product['status'] as String;
    final statusColor = _getStatusColor(status);
    final currentStock = product['currentStock'] as int;
    final minStock = product['minStock'] as int;
    final stockPercentage = currentStock / minStock;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product['image'],
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 64,
                        height: 64,
                        color: AppTheme.cardBackground,
                        child: const Icon(Icons.image, color: AppTheme.textLight),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: AppTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${product['price']}đ/${product['unit']}',
                        style: AppTheme.price.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: statusColor),
                            ),
                            child: Text(
                              _getStatusText(status),
                              style: AppTheme.caption.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Action Button
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: AppTheme.primary),
                  onPressed: () => _showUpdateStockDialog(product),
                ),
              ],
            ),
          ),
          
          // Stock Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tồn kho: ${product['currentStock']} ${product['unit']}',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      'Tối thiểu: ${product['minStock']} ${product['unit']}',
                      style: AppTheme.caption.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: stockPercentage > 1 ? 1 : stockPercentage,
                    minHeight: 8,
                    backgroundColor: AppTheme.borderColor,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}