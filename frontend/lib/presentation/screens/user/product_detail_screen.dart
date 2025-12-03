// lib/presentation/screens/user/product_detail_screen.dart
import 'package:flutter/material.dart';
import '../../../../data/models/product_user.dart';
import '../../../../services/product_service.dart';
import '../../widgets/user/component/product_detail_header.dart';
import '../../widgets/user/productdetail/product_image_carousel.dart';
import '../../widgets/user/component/product_info_card.dart';
import '../../widgets/user/productdetail/product_rating_section.dart';
import '../../widgets/user/productdetail/product_description.dart';
import '../../widgets/user/productdetail/seller_info_card.dart';
import '../../widgets/user/component/review_list.dart';
import '../../widgets/user/component/related_products.dart';
import '../../widgets/user/component/product_bottom_bar.dart';
import 'package:eco_nova_app/presentation/widgets/user/component/build_product_image.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId; // Receive ID for API load
  final String? heroTag;

  const ProductDetailPage({
    Key? key,
    required this.productId,
    this.heroTag,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Product? _product;
  bool _isLoading = true;
  int quantity = 1;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadProductDetail();
  }

  Future<void> _loadProductDetail() async {
    try {
      final result = await ProductService.getProductDetail(widget.productId);
      setState(() {
        _product = Product.fromJson(result);
        _isLoading = false;
      });
    } catch (e) {
      print('Load product detail error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi tải chi tiết sản phẩm: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  void _incrementQuantity() {
    setState(() => quantity++);
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() => quantity--);
    }
  }

  void _toggleFavorite() {
    setState(() => isFavorite = !isFavorite);
    // TODO: Call API to toggle favorite
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _product == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final product = _product!;
    final heroTag = widget.heroTag ?? product.id;
    final title = product.name;
    final shop = product.sellerName;
    final price = product.formattedPrice;
    final rating = product.rating.toStringAsFixed(1);
    final discount = product.discountText;
    final badges = product.displayBadges;
    final seller = product.seller;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDetailHeader(
                  isFavorite: isFavorite,
                  onFavoriteToggle: _toggleFavorite,
                ),
                ProductImageCarousel(
                  heroTag: heroTag,
                  images: product.images, // Pass full images list
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductInfoCard(
                        title: title,
                        price: price,
                        discount: discount,
                        badges: badges,
                      ),
                      const SizedBox(height: 16),
                      ProductRatingSection(
                        rating: rating,
                        reviewCount: '${product.reviewCount}',
                        soldCount: '${product.soldCount}',
                      ),
                      const SizedBox(height: 16),
                      ProductDescription(
                        detailedDescription: product.detailedDescription,
                        origin: product.origin,
                        storageInstructions: product.storageInstructions,
                        shelfLife: product.shelfLife,
                        nutritionInfo: product.nutritionInfo,
                      ),
                      const SizedBox(height: 16),
                      SellerInfoCard(
                        seller: seller,
                        shopName: shop,
                      ),
                      const SizedBox(height: 16),
                      ReviewList(
                        // productId: product.id,
                        // reviewCount: product.reviewCount,
                      ),
                      const SizedBox(height: 16),
                      RelatedProducts(
                        // categoryId: product.category.id,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ProductBottomBar(
              quantity: quantity,
              price: price,
              onIncrement: _incrementQuantity,
              onDecrement: _decrementQuantity,
            ),
          ),
        ],
      ),
    );
  }
}