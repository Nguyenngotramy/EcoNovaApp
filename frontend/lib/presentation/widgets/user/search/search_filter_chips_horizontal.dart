// lib/presentation/widgets/user/search/search_filter_chips_horizontal.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SearchFilterChipsHorizontal extends StatelessWidget {
  final Map<String, VoidCallback> activeFilters;
  final VoidCallback? onClear;

  const SearchFilterChipsHorizontal({
    Key? key,
    required this.activeFilters,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...activeFilters.entries.map((entry) => Container(
                margin: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(entry.key),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: entry.value,
                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                  labelStyle: const TextStyle(color: AppTheme.primary, fontSize: 12),
                ),
              )),
          if (onClear != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onClear,
              child: Text(
                'Xóa tất cả',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}