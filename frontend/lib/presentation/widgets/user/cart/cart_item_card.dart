import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/cart_item.dart';
import 'package:eco_nova_app/presentation/widgets/user/component/build_product_image.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onDelete;
  final Function(int) onQuantityChange;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onQuantityChange,
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
          // Hình ảnh sản phẩm
          Container(
            child: buildProductImage(
              imageUrl: item.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,               // <-- FIX 2
            ),
          ),
          const SizedBox(width: 12),

          // Tên và giá
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTheme.bodyMedium),
                const SizedBox(height: 4),
                Text('${item.price.toStringAsFixed(0)}₫', style: AppTheme.price),
              ],
            ),
          ),

          // Delete
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppTheme.errorColor),
            onPressed: onDelete,
          ),

          // Số lượng + tăng giảm
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => onQuantityChange(-1),
                  child: const Icon(Icons.remove_circle, color: AppTheme.primary, size: 20),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(item.quantity.toString(), style: AppTheme.bodyMedium),
                ),
                GestureDetector(
                  onTap: () => onQuantityChange(1),
                  child: const Icon(Icons.add_circle, color: AppTheme.primary, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
