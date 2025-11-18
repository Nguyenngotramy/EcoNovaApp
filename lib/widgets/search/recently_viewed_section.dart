import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RecentlyViewedSection extends StatelessWidget {
  const RecentlyViewedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      {'image': 'assets/images/tomato.jpg', 'title': 'Cà chua xanh', 'price': '28,000'},
      {'image': 'assets/images/cauliflower.jpg', 'title': 'Súp lơ trắng', 'price': '32,000'},
      {'image': 'assets/images/cabbage.jpg', 'title': 'Rau cải ngọt', 'price': '15,000'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Các sản phẩm xem gần đây', style: AppTheme.heading3),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return RecentProductCard(
                image: products[index]['image']!,
                title: products[index]['title']!,
                price: products[index]['price']!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecentProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const RecentProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.bodySmall.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$price\u20ABVND/1kg',
                  style: AppTheme.price.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}