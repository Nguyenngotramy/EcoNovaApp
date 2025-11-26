
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CategoryManagementScreen extends StatefulWidget {
  final int? categoryId;
  final String? categoryTitle;

  const CategoryManagementScreen({
    Key? key,
    this.categoryId,
    this.categoryTitle,
  }) : super(key: key);

  @override
  State<CategoryManagementScreen> createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final List<Category> categories = [
    Category(
      id: 1,
      emoji: '🍎',
      name: 'Trái cây',
      productCount: 24,
      color: Colors.red.shade50,
      products: [
        Product(id: '1-1', name: 'Táo xanh', stock: 50, unit: 'kg', price: 45000),
        Product(id: '1-2', name: 'Cam sành', stock: 80, unit: 'kg', price: 35000),
        Product(id: '1-3', name: 'Chuối tiêu', stock: 100, unit: 'nải', price: 25000),
        Product(id: '1-4', name: 'Xoài cát', stock: 30, unit: 'kg', price: 60000),
      ],
    ),
    Category(
      id: 2,
      emoji: '🥬',
      name: 'Rau xanh',
      productCount: 18,
      color: Colors.green.shade50,
      products: [
        Product(id: '2-1', name: 'Xà lách xanh', stock: 25, unit: 'kg', price: 25000),
        Product(id: '2-2', name: 'Cải ngọt', stock: 40, unit: 'kg', price: 20000),
        Product(id: '2-3', name: 'Rau muống', stock: 35, unit: 'kg', price: 15000),
        Product(id: '2-4', name: 'Cải thìa', stock: 30, unit: 'kg', price: 18000),
      ],
    ),
    Category(
      id: 3,
      emoji: '🌾',
      name: 'Ngũ cốc',
      productCount: 12,
      color: Colors.amber.shade50,
      products: [
        Product(id: '3-1', name: 'Gạo ST25', stock: 200, unit: 'kg', price: 35000),
        Product(id: '3-2', name: 'Ngô ngọt', stock: 60, unit: 'kg', price: 22000),
        Product(id: '3-3', name: 'Đậu xanh', stock: 45, unit: 'kg', price: 40000),
        Product(id: '3-4', name: 'Đậu đỏ', stock: 38, unit: 'kg', price: 38000),
      ],
    ),
    Category(
      id: 4,
      emoji: '🥕',
      name: 'Củ quả',
      productCount: 15,
      color: Colors.orange.shade50,
      products: [
        Product(id: '4-1', name: 'Cà rốt baby', stock: 5, unit: 'kg', price: 35000, isLowStock: true),
        Product(id: '4-2', name: 'Khoai tây', stock: 120, unit: 'kg', price: 18000),
        Product(id: '4-3', name: 'Khoai lang', stock: 80, unit: 'kg', price: 20000),
        Product(id: '4-4', name: 'Củ cải trắng', stock: 45, unit: 'kg', price: 15000),
      ],
    ),
    Category(
      id: 5,
      emoji: '🍅',
      name: 'Rau gia vị',
      productCount: 20,
      color: Colors.red.shade50,
      products: [
        Product(id: '5-1', name: 'Cà chua cherry', stock: 40, unit: 'kg', price: 40000),
        Product(id: '5-2', name: 'Ớt hiểm', stock: 15, unit: 'kg', price: 55000),
        Product(id: '5-3', name: 'Hành tây', stock: 55, unit: 'kg', price: 22000),
        Product(id: '5-4', name: 'Tỏi', stock: 30, unit: 'kg', price: 45000),
      ],
    ),
    Category(
      id: 6,
      emoji: '🥗',
      name: 'Rau ăn sống',
      productCount: 10,
      color: Colors.green.shade100,
      products: [
        Product(id: '6-1', name: 'Rau mầm', stock: 12, unit: 'kg', price: 60000),
        Product(id: '6-2', name: 'Xà lách tím', stock: 18, unit: 'kg', price: 30000),
        Product(id: '6-3', name: 'Cải bẹ xanh', stock: 25, unit: 'kg', price: 22000),
        Product(id: '6-4', name: 'Rau càng cua', stock: 20, unit: 'kg', price: 35000),
      ],
    ),
  ];

  String searchQuery = '';

  List<Category> get filteredCategories {
    if (searchQuery.isEmpty) return categories;
    return categories.where((cat) => 
      cat.name.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  int get totalProducts {
    return categories.fold(0, (sum, cat) => sum + cat.productCount);
  }

  int get lowStockCount {
    int count = 0;
    for (var category in categories) {
      count += category.products.where((p) => p.isLowStock).length;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.categoryTitle ?? 'Danh mục sản phẩm';
    return Scaffold(
      backgroundColor: AppTheme.cardBackground,
      appBar: AppBar(
        title: Text(title, style: AppTheme.heading3),
        actions: [
          if (widget.categoryId == null)  // Chỉ hiển thị add nếu là màn quản lý tổng
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddCategoryDialog,
            ),
        ],
      ),
      body: Column(
        children: [
          if (widget.categoryId == null)  // Chỉ hiển thị stats nếu quản lý tổng
            Container(
              color: AppTheme.background,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Responsive stat cards: Sử dụng Wrap nếu màn hình nhỏ
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmallScreen = constraints.maxWidth < 600;
                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildStatCard(
                            'Tổng danh mục',
                            '${categories.length}',
                            Icons.category_outlined,
                            AppTheme.primary,
                          ),
                          _buildStatCard(
                            'Tổng sản phẩm',
                            '$totalProducts',
                            Icons.inventory_2_outlined,
                            AppTheme.successColor,
                          ),
                          _buildStatCard(
                            'Sắp hết',
                            '$lowStockCount',
                            Icons.warning_outlined,
                            AppTheme.warningColor,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm danh mục...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                return _buildCategoryCard(category);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 48) / 3 - 12,  // Responsive width
      height: 80,  // Fix: Add fixed height to bound the Column
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Fix: Center to fit in bounded height
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTheme.heading2.copyWith(color: color),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Category category) {
    return GestureDetector(
      onTap: () => _showCategoryDetail(category),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: IntrinsicHeight(  // Fix: Use IntrinsicHeight for action buttons row
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category.emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              category.name,
                              style: AppTheme.heading3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${category.productCount} sản phẩm',
                            style: AppTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppTheme.textLight,
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: AppTheme.borderColor,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                      Icons.edit_outlined,
                      'Sửa',
                      () => _showEditCategoryDialog(category),
                    ),
                    _buildActionButton(
                      Icons.add,
                      'Thêm SP',
                      () => _showAddProductDialog(category),
                    ),
                    _buildActionButton(
                      Icons.visibility_outlined,
                      'Xem chi tiết',
                      () => _showCategoryDetail(category),
                    ),
                    _buildActionButton(
                      Icons.delete_outlined,
                      'Xóa',
                      () => _showDeleteCategoryDialog(category),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return Expanded(  // Fix: Wrap in Expanded to bound width in Row
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppTheme.primary, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.caption.copyWith(color: AppTheme.primary),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,  // Fix: Ellipsis if label long
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDetail(Category category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category.emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(category.name, style: AppTheme.heading2),
                          Text(
                            '${category.products.length} sản phẩm',
                            style: AppTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  itemCount: category.products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = category.products[index];
                    return _buildProductItem(product);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: product.isLowStock ? AppTheme.warningColor.withOpacity(0.1) : AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: product.isLowStock ? AppTheme.warningColor : AppTheme.borderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        product.name,
                        style: AppTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (product.isLowStock)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.warningColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Sắp hết',
                          style: AppTheme.caption.copyWith(
                            color: AppTheme.background,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Tồn kho: ${product.stock}${product.unit}',
                  style: AppTheme.bodySmall,
                ),
                Text(
                  '${product.price.toStringAsFixed(0)}đ/${product.unit}',
                  style: AppTheme.price,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm danh mục mới'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Tên danh mục',
            hintText: 'Nhập tên danh mục',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập tên danh mục')),
                );
                return;
              }
              // TODO: Add category to list/DB
              setState(() {
                categories.add(Category(
                  id: categories.length + 1,
                  emoji: '📁',  // Default emoji
                  name: nameController.text,
                  productCount: 0,
                  color: Colors.grey.shade50,
                  products: [],
                ));
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã thêm danh mục "${nameController.text}"')),
              );
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }

  void _showEditCategoryDialog(Category category) {
    final nameController = TextEditingController(text: category.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sửa danh mục'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Tên danh mục',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập tên danh mục')),
                );
                return;
              }
              setState(() {
                category.name = nameController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã cập nhật danh mục "${nameController.text}"')),
              );
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _showDeleteCategoryDialog(Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa danh mục'),
        content: Text('Bạn có chắc chắn muốn xóa "${category.name}"? (Sẽ xóa ${category.products.length} sản phẩm)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                categories.remove(category);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã xóa danh mục "${category.name}"')),
              );
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thêm sản phẩm vào ${category.name}'),
        content: const Text('Chức năng đang phát triển'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}

class Category {
  int id;  // Changed to int
  String emoji;
  String name;
  int productCount;
  Color color;
  List<Product> products;

  Category({
    required this.id,
    required this.emoji,
    required this.name,
    required this.productCount,
    required this.color,
    required this.products,
  });
}

class Product {
  final String id;  // Thêm ID cho Product
  final String name;
  final int stock;
  final String unit;
  final double price;
  final bool isLowStock;

  Product({
    required this.id,  // Required ID
    required this.name,
    required this.stock,
    required this.unit,
    required this.price,
    this.isLowStock = false,
  });
}