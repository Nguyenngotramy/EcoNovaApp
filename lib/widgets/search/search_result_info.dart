import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SearchResultInfo extends StatelessWidget {
  final String query;
  final int count;

  const SearchResultInfo({Key? key, required this.query, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppTheme.secondaryLight.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.textPrimary),
              children: [
                const TextSpan(text: 'Tìm thấy '),
                TextSpan(
                  text: '$count kết quả',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' cho '),
                TextSpan(
                  text: '"$query"',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            '0.3 giây',
            style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}