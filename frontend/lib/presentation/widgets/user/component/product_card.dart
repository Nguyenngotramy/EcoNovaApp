import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../screens/user/product_detail_screen.dart';
import 'build_product_image.dart';
import '../../../../data/models/product_user.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heroTag = product.id;
    final imageUrl = product.images.isNotEmpty ? product.images.first : '';

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        onTap?.call();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              productId: product.id,
              heroTag: heroTag,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,                         // <-- FIX 1: full width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // IMAGE SECTION
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  Hero(
                    tag: heroTag,
                    child: buildProductImage(
                      imageUrl: imageUrl,
                      height: 120,
                      fit: BoxFit.cover,               // <-- FIX 2
                    ),
                  ),
                  const Positioned(top: 8, right: 8, child: CircleFavoriteButton()),
                  if (product.displayBadges.isNotEmpty)
                    Positioned(
                      top: 8, 
                      left: 8, 
                      child: _buildSingleBadge(product.displayBadges.first),
                    ),
                ],
              ),
            ),

            // TEXT SECTION
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    product.name,
                    style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.seller.username,
                    style: AppTheme.caption.copyWith(color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text(
                        '${product.formattedPrice} ',
                        style: AppTheme.price.copyWith(
                          fontSize: 15.5, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      if (product.discountText != null) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            product.discountText!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11.5, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.star, size: 15, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: AppTheme.bodySmall,
                      ),
                      Text(
                        ' (${product.reviewCount})',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
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
    final colorMap = {
      'VietGAP': Colors.green,
      'Organic': Colors.green.shade700,
      'Flash Sale': Colors.orange,
      'Freeship': Colors.blue,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorMap[text] ?? Colors.grey.shade600,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, 
          fontSize: 10.5, 
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}

class CircleFavoriteButton extends StatelessWidget {
  const CircleFavoriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6)
        ],
      ),
      child: const Icon(Icons.favorite_border, size: 18, color: Colors.grey),
    );
  }
}
