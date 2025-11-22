import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Đánh giá (103)', style: AppTheme.heading3),
            TextButton(
              onPressed: () {},
              child: const Text('Xem tất cả'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildReviewItem(
          'Nguyen Anh Khuoi',
          5,
          'Cà chua tươi ngon, chất lượng. Đóng gói cẩn thận, giao hàng nhanh. Sẽ tiếp tục mua.',
          'https://picsum.photos/60/60?random=10',
        ),
        const Divider(height: 24),
        _buildReviewItem(
          'Thanh Nguyễn',
          5,
          'Sản phẩm đúng mô tả, rất hài lòng.',
          'https://picsum.photos/60/60?random=11',
        ),
      ],
    );
  }

  Widget _buildReviewItem(String name, int rating, String comment, String image) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(image),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 14,
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(comment, style: AppTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}