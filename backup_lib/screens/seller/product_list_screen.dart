import 'package:eco_nova_app/widgets/seller/home/section_header.dart';
import 'package:eco_nova_app/widgets/seller/products/addproductscreen.dart';
import 'package:eco_nova_app/widgets/seller/products/editproductscreen.dart';
import 'package:eco_nova_app/widgets/seller/products/search_filter_bar.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/seller/products/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;

  // Mock data for products
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Cà chua cherry',
      'weight': '1kg',
      'price': '40.000đ',
      'stock': 50,
      'status': 'Còn hàng',
      'statusColor': AppTheme.successColor,
    },
    {
      'id': '2',
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Xà lách xanh',
      'weight': '500g',
      'price': '25.000đ',
      'stock': 30,
      'status': 'Còn hàng',
      'statusColor': AppTheme.successColor,
    },
    {
      'id': '3',
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Cà rốt baby',
      'weight': '1kg',
      'price': '35.000đ',
      'stock': 5,
      'status': 'Sắp hết',
      'statusColor': AppTheme.warningColor,
    },
    {
      'id': '4',
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Súp lơ xanh',
      'weight': '1kg',
      'price': '45.000đ',
      'stock': 0,
      'status': 'Hết hàng',
      'statusColor': AppTheme.errorColor,
    },
    {
      'id': '5',
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Cải bó xôi',
      'weight': '500g',
      'price': '20.000đ',
      'stock': 40,
      'status': 'Còn hàng',
      'statusColor': AppTheme.successColor,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lọc theo danh mục', style: AppTheme.heading2),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip('Tất cả', null),
                _buildFilterChip('Trái cây', 'fruit'),
                _buildFilterChip('Rau xanh', 'vegetable'),
                _buildFilterChip('Ngũ cốc', 'grain'),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String? value) {
    final isSelected = _selectedCategory == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedCategory = selected ? value : null;
        });
        Navigator.pop(context);
      },
      backgroundColor: AppTheme.cardBackground,
      selectedColor: AppTheme.primary.withOpacity(0.1),
      labelStyle: AppTheme.bodyMedium.copyWith(
        color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? AppTheme.primary : AppTheme.borderColor,
      ),
    );
  }

  void _editProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(productId: "1",),
      ),
    ).then((updatedProduct) {
      if (updatedProduct != null) {
        // Update the product in the list
        final index = _products.indexWhere((p) => p['id'] == product['id']);
        if (index != -1) {
          setState(() {
            _products[index] = updatedProduct;
          });
        }
      }
    });
  }

  void _deleteProduct(String productId) {
    // Placeholder for delete logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa sản phẩm'),
        content: const Text('Bạn có chắc chắn muốn xóa sản phẩm này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _products.removeWhere((p) => p['id'] == productId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa sản phẩm!')),
              );
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter products based on category (placeholder logic)
    final filteredProducts = _selectedCategory == null
        ? _products
        : _products.where((p) => p.containsValue(_selectedCategory)).toList();

    return Scaffold(
      backgroundColor: AppTheme.cardBackground,
      appBar: AppBar(
        title: const Text('Sản phẩm', style: AppTheme.heading2),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to add product screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductScreen(),
                ),
              ).then((newProduct) {
                if (newProduct != null) {
                  setState(() {
                    _products.add(newProduct);
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchFilterBar(
              searchController: _searchController,
              onFilterTap: _showFilterDialog,
              selectedCategory: _selectedCategory,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredProducts.length + 1,  // +1 for SectionHeader
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      SectionHeader(
                        title: 'Tất cả sản phẩm',
                        actionText: '${filteredProducts.length} sản phẩm',
                        onActionTap: null,
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }
                final product = filteredProducts[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ProductCard(
                    imageUrl: product['imageUrl'],
                    name: product['name'],
                    weight: product['weight'],
                    price: product['price'],
                    stock: product['stock'],
                    status: product['status'],
                    statusColor: product['statusColor'],
                    onEdit: () => _editProduct(product),
                    onDelete: () => _deleteProduct(product['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          ).then((newProduct) {
            if (newProduct != null) {
              setState(() {
                _products.add(newProduct);
              });
            }
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('Thêm sản phẩm'),
      ),
    );
  }
}

