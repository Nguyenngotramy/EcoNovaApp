import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class ProductInfoCard extends StatelessWidget {
  final String title;
  final String price;
  final String? discount;
  final List<String> badges;

  const ProductInfoCard({
    Key? key,
    required this.title,
    required this.price,
    this.discount,
    this.badges = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (badges.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: badges.map((badge) => _buildBadge(badge)).toList(),
          ),
        if (badges.isNotEmpty) const SizedBox(height: 12),
        Text(title, style: AppTheme.heading2),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$price VNĐ',
              style: AppTheme.price.copyWith(fontSize: 24),
            ),
            const SizedBox(width: 8),
            if (discount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  discount!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Text(
              '/kg',
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(String text) {
    final colorMap = {
      'VietGAP': Colors.green,
      'Organic': Colors.green.shade700,
      'organic': Colors.green.shade700,
      'Flash Sale': Colors.orange,
      'FLASH SALE': Colors.orange,
      'Freeship': Colors.blue,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorMap[text] ?? AppTheme.secondaryLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: colorMap[text] != null ? Colors.white : AppTheme.primary,
        ),
      ),
    );
  }
}