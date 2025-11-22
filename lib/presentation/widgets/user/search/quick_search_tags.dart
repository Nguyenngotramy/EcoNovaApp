import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class QuickSearchTags extends StatelessWidget {
  const QuickSearchTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tags = [
      'Cà chua Đà Lạt',
      'Nông sản tươi',
      'Rau củ ngọt',
      'Trái cây vườn',
      'Gà vườn',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tìm kiếm liên quan', style: AppTheme.heading3),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) => SearchTag(label: tag)).toList(),
          ),
        ],
      ),
    );
  }
}

class SearchTag extends StatelessWidget {
  final String label;

  const SearchTag({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Text(
          label,
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}