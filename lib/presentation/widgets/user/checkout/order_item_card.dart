
import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/data/models/product.dart';
import 'package:flutter/material.dart';


class OrderItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onAdd;

  const OrderItemCard({
    Key? key,
    required this.product,
    required this.onDelete,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(product.image, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: AppTheme.bodyMedium),
                const SizedBox(height: 4),
                Text('${product.price.toStringAsFixed(0)}₫', style: AppTheme.price),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppTheme.errorColor),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('${product.quantity}', style: AppTheme.bodyMedium),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onAdd,
            child: const Icon(Icons.add_circle, color: AppTheme.primary, size: 24),
          ),
        ],
      ),
    );
  }
}