import 'package:eco_nova_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SearchProductGrid extends StatelessWidget {
  const SearchProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = List.generate(4, (index) {
      return {
        'image': 'assets/images/1.jpg',
        'title': 'Cà chua bi organic',
        'rating': '4.9',
        'distance': '1.8 km',
        'price': '45,000',
        'originalPrice': index % 2 == 0 ? '65,000' : null,
        'discount': index % 2 == 0 ? '-18%' : null,
        'badge': 'VietGAP',
        'shop': 'Organic Farm', // Added shop for ProductDetailPage
      };
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return SearchProductCard(
            image: product['image'] as String,
            title: product['title'] as String,
            rating: product['rating'] as String,
            distance: product['distance'] as String,
            price: product['price'] as String,
            originalPrice: product['originalPrice'] as String?,
            discount: product['discount'] as String?,
            badge: product['badge'] as String,
            shop: product['shop'] as String, // Pass shop to card
          );
        },
      ),
    );
  }
}

class SearchProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String rating;
  final String distance;
  final String price;
  final String? originalPrice;
  final String? discount;
  final String badge;
  final String shop; // Added shop parameter

  const SearchProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.rating,
    required this.distance,
    required this.price,
    this.originalPrice,
    this.discount,
    required this.badge,
    required this.shop, // Required shop
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
              badges: [badge], // Convert single badge to list for badges
            ),
          ),
        );
      },
      child: Container( // Added child: to InkWell
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    image,
                    height: 115,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border, size: 18, color: Colors.grey),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(rating, style: AppTheme.bodySmall),
                      const SizedBox(width: 8),
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(distance, style: AppTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '$price\u20ABVND/kg',
                        style: AppTheme.price.copyWith(fontSize: 12),
                      ),
                      if (discount != null) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            discount!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (originalPrice != null)
                    Text(
                      '$originalPrice\u20ABVND/kg',
                      style: AppTheme.bodySmall.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppTheme.textLight,
                        fontSize: 10,
                      ),
                    ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: const Text(
                        'Mua Ngay',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}