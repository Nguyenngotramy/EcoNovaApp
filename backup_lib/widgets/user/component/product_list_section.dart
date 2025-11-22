// product_list_section.dart
import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import 'product_card.dart';

class ProductListSection extends StatelessWidget {
  const ProductListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sản phẩm nổi bật', style: AppTheme.heading3),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Xem tất cả',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 18, color: AppTheme.primary),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

 GridView.count(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  crossAxisCount: 2,
  childAspectRatio: 0.72,
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
  children: [
    ProductCard(
      image: 'assets/images/2.jpg',   // ảnh từ assets
      title: 'Cà chua hữu cơ Đà Lạt',
      shop: 'Nông trại Xanh',
      price: '29.000',
      rating: '4.9',
      discount: '-42%',
      badges: ['VietGAP'],
    ),
    ProductCard(
      image: 'assets/images/1.jpg',
      title: 'Thịt heo sạch CP',
      shop: 'Meat Master',
      price: '119.000',
      rating: '4.8',
      discount: '-10%',
      badges: ['Flash Sale'],
    ),
    ProductCard(
      image: 'assets/images/1.jpg',
      title: 'Bơ booth Đà Lạt chính vụ',
      shop: 'Bơ Sài Gòn',
      price: '69.000',
      rating: '5.0',
      discount: '-35%',
      badges: ['Organic'],
    ),
    ProductCard(
      image: 'assets/images/2.jpg',
      title: 'Trứng gà ta thả vườn (10 quả)',
      shop: 'Trại Anh Thư',
      price: '42.000',
      rating: '4.7',
      badges: ['Organic'],
    ),
    ProductCard(
      image: 'assets/images/2.jpg',
      title: 'Rau cải ngọt baby thủy canh',
      shop: 'Home Farm',
      price: '18.000',
      rating: '4.9',
      discount: '-25%',
      badges: ['VietGAP'],
    ),
    ProductCard(
      image: 'assets/images/1.jpg',
      title: 'Nước mắm Phú Quốc 40 độ đạm',
      shop: 'Nước mắm Tĩn',
      price: '89.000',
      rating: '4.9',
      discount: '-20%',
      badges: ['VietGAP'],
    ),
    ProductCard(
      image: 'assets/images/2.jpg',
      title: 'Khoai lang mật Nhật',
      shop: 'Khoai Lang VN',
      price: '35.000',
      rating: '4.8',
      discount: '-30%',
      badges: ['Freeship'],
    ),
    ProductCard(
      image: 'assets/images/1.jpg',
      title: 'Cá hồi Na Uy fillet tươi',
      shop: 'Seafood Premium',
      price: '289.000',
      rating: '5.0',
      discount: '-5K',
      badges: ['Flash Sale'],
    ),
  ],
),
        ],
      ),
    );
  }
}