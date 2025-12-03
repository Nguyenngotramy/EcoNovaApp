import 'package:eco_nova_app/presentation/screens/user/product_detail_screen.dart';
import 'package:eco_nova_app/presentation/widgets/user/component/build_product_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'product_card.dart';
import '../../../../services/auth_service.dart'; 
import '../../../../services/product_service.dart'; 
import '../../../../data/models/product_user.dart';

class ProductListSection extends StatefulWidget {
  const ProductListSection({Key? key}) : super(key: key);

  @override
  State<ProductListSection> createState() => _ProductListSectionState();
}

class _ProductListSectionState extends State<ProductListSection> {
  List<Product> _products = [];
  bool _isLoadingProducts = true;

  @override
  void initState() {
    super.initState();
    _loadProductFeatured();
  }

  Future<void> _loadProductFeatured() async {
    setState(() => _isLoadingProducts = true);

    try {
      // Gọi API lấy sản phẩm nổi bật
      final List<dynamic> jsonProducts = await ProductService.getFeaturedProducts();
      
      setState(() {
        _products = jsonProducts
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print('Load featured products error: $e');
      _showSnackBar('Lỗi khi tải sản phẩm nổi bật: $e', isError: true);
    } finally {
      setState(() => _isLoadingProducts = false);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sản phẩm nổi bật', style: AppTheme.heading3),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to all products page
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Xem tất cả',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 18, color: AppTheme.primary),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Content
          if (_isLoadingProducts)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: CircularProgressIndicator(),
              ),
            )
          else if (_products.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Không có sản phẩm nổi bật',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                
                return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(productId: product.id),
                    ),
                  );
                },
              );
              },
            ),
        ],
      ),
    );
  }
}