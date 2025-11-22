import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SellerInfoCard extends StatelessWidget {
  const SellerInfoCard({Key? key, required String shopName}) : super(key: key);

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
                    child: Text('H', style: AppTheme.heading3.copyWith(color: AppTheme.primary)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Harvest Hub Saigon', style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                        Text('Hoạt động 2 giờ trước', style: AppTheme.caption),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Theo dõi'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildStatItem('12,8', 'Sản phẩm')),
                  Expanded(child: _buildStatItem('90.5%', 'Đánh giá')),
                  Expanded(child: _buildStatItem('45,2', 'Phản hồi')),
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