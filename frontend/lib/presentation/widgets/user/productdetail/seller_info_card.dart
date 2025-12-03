// lib/presentation/widgets/user/productdetail/seller_info_card.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/product_user.dart';

class SellerInfoCard extends StatelessWidget {
  final Seller seller;
  final String shopName;

  const SellerInfoCard({
    Key? key,
    required this.seller,
    required this.shopName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thông tin người bán', style: AppTheme.heading3),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.secondaryLight,
                    child: Text(
                      seller.username.isNotEmpty ? seller.username[0].toUpperCase() : 'S',
                      style: AppTheme.heading3.copyWith(color: AppTheme.primary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(shopName, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                        Text('${seller.email} • Hoạt động gần đây', style: AppTheme.caption),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Follow seller
                    },
                    child: const Text('Theo dõi'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildStatItem('124', 'Sản phẩm')), // Load from API if available
                  Expanded(child: _buildStatItem('4.8', 'Đánh giá')),
                  Expanded(child: _buildStatItem('98%', 'Phản hồi')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTheme.heading3.copyWith(color: AppTheme.primary)),
        const SizedBox(height: 4),
        Text(label, style: AppTheme.caption),
      ],
    );
  }
}