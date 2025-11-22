import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class OrderProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String weight;
  final int quantity;
  final String price;
  final String totalPrice;

  const OrderProductItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.weight,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: AppTheme.cardBackground,
                child: const Icon(Icons.image, color: AppTheme.textLight),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  weight,
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      price,
                      style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                    ),
                    Text(
                      ' x $quantity',
                      style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(totalPrice, style: AppTheme.price),
        ],
      ),
    );
  }
}