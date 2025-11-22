import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class RelatedProductCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final String unit;
  final double rating;
  final String distance;
  final int discount;
  final VoidCallback onAddToCart;

  const RelatedProductCard({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.unit,
    required this.rating,
    required this.distance,
    this.discount = 0,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Center(child: Text(image, style: const TextStyle(fontSize: 48))),
                if (discount > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-$discount%',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: AppTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 12),
              const SizedBox(width: 4),
              Text('$rating', style: AppTheme.caption),
              const SizedBox(width: 4),
              const Icon(Icons.location_on, color: AppTheme.textLight, size: 12),
              const SizedBox(width: 2),
              Text(distance, style: AppTheme.caption),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${price.toStringAsFixed(0)}₫/$unit',
                  style: AppTheme.price.copyWith(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onAddToCart,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}