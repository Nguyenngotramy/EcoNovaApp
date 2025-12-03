// lib/presentation/widgets/user/productdetail/product_rating_section.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ProductRatingSection extends StatelessWidget {
  final String rating;
  final String reviewCount;
  final String soldCount;

  const ProductRatingSection({
    Key? key,
    required this.rating,
    required this.reviewCount,
    required this.soldCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildRatingItem(Icons.star, rating, '$reviewCount đánh giá'),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppTheme.borderColor,
          ),
          Expanded(
            child: _buildRatingItem(Icons.shopping_bag, soldCount, 'Đã bán'),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppTheme.primary),
            const SizedBox(width: 4),
            Text(value, style: AppTheme.heading3),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTheme.caption),
      ],
    );
  }
}