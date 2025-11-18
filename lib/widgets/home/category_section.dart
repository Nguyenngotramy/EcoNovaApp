import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_theme.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Danh mục', style: AppTheme.heading3),
              TextButton(
                onPressed: () {},
                child: Text('Xem tất cả', style: AppTheme.bodyMedium),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryItem(LucideIcons.leafyGreen, 'Rau củ', const Color.fromARGB(255, 255, 255, 255)),
              _buildCategoryItem(LucideIcons.cherry, 'Trái cây', const Color.fromARGB(255, 255, 255, 255)),
              _buildCategoryItem(LucideIcons.fish, 'Thịt cá', const Color.fromARGB(255, 255, 255, 255)),
              _buildCategoryItem(LucideIcons.coffee, 'Đồ khô', const Color.fromARGB(255, 255, 255, 255)),
              
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color bgColor) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: Icon(
            icon,
            color: AppTheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTheme.bodySmall),
      ],
    );
  }
}