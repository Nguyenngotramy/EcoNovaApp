// lib/widgets/product_card.dart (đã sửa hoàn chỉnh)
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String shop;
  final String price;
  final String rating;
  final String? discount;
  final List<String> badges;

  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.shop,
    required this.price,
    required this.rating,
    this.discount,
    this.badges = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String heroTag = 'product_${title}_$price'; // Đảm bảo unique

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              heroTag: heroTag,
              image: image,
              title: title,
              shop: shop,
              price: price,
              rating: rating,
              discount: discount,
              badges: badges,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: heroTag,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      image,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(top: 8, right: 8, child: CircleFavoriteButton()),
                if (badges.isNotEmpty)
                  Positioned(top: 8, left: 8, child: _buildSingleBadge(badges.first)),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(shop, style: AppTheme.caption.copyWith(color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text('$price đ', style: AppTheme.price.copyWith(fontSize: 15.5, fontWeight: FontWeight.bold)),
                      if (discount != null) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                          child: Text(discount!, style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 15, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(rating, style: AppTheme.bodySmall),
                      Text(' (128)', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleBadge(String text) {
    final colorMap = {'VietGAP': Colors.green, 'Organic': Colors.green.shade700, 'Flash Sale': Colors.orange, 'Freeship': Colors.blue};
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: colorMap[text] ?? Colors.grey.shade600, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w600)),
    );
  }
}

class CircleFavoriteButton extends StatelessWidget {
  const CircleFavoriteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
      child: const Icon(Icons.favorite_border, size: 18, color: Colors.grey),
    );
  }
}