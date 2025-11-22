import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String emoji;
  final String title;
  final int count;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.emoji,
    required this.title,
    required this.count,
    required this.onTap, required int id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text(title, style: AppTheme.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(
              '$count sản phẩm',
              style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}