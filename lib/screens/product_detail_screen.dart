import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/product_detail_header.dart';
import '../widgets/productdetail/product_image_carousel.dart';
import '../widgets/product_info_card.dart';
import '../widgets/productdetail/product_rating_section.dart';
import '../widgets/productdetail/product_description.dart';
import '../widgets/productdetail/seller_info_card.dart';
import '../widgets/review_list.dart';
import '../widgets/related_products.dart';
import '../widgets/product_bottom_bar.dart';

class ProductDetailPage extends StatefulWidget {
  final String heroTag;
  final String image;
  final String title;
  final String shop;
  final String price;
  final String rating;
  final String? discount;
  final List<String> badges;

   ProductDetailPage({
    Key? key,
    required this.heroTag,
    required this.image,
    required this.title,
    required this.shop,
    required this.price,
    required this.rating,
    this.discount,
    this.badges = const [],
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  bool isFavorite = false;

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
  }

  @override
  Widget build(BuildContext context) {
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
                  heroTag: widget.heroTag,
                  mainImage: widget.image,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductInfoCard(
                        title: widget.title,
                        price: widget.price,
                        discount: widget.discount,
                        badges: widget.badges,
                      ),
                      const SizedBox(height: 16),
                      ProductRatingSection(rating: widget.rating),
                      const SizedBox(height: 16),
                      const ProductDescription(),
                      const SizedBox(height: 16),
                      SellerInfoCard(shopName: widget.shop),
                      const SizedBox(height: 16),
                      const ReviewList(),
                      const SizedBox(height: 16),
                      const RelatedProducts(),
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
              price: widget.price,
              onIncrement: _incrementQuantity,
              onDecrement: _decrementQuantity,
            ),
          ),
        ],
      ),
    );
  }
}