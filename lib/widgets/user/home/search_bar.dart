import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppTheme.textLight),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm trên app',
                  hintStyle: AppTheme.bodyMedium.copyWith(color: AppTheme.textLight),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Icon(Icons.mic_none, color: AppTheme.textLight),
          ],
        ),
      ),
    );
  }
}