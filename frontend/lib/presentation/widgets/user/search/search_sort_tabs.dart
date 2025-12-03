// lib/presentation/widgets/user/search/search_sort_tabs.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SearchSortTabs extends StatelessWidget {
  final String currentSort;
  final Function(String) onSortChanged;

  const SearchSortTabs({
    Key? key,
    required this.currentSort,
    required this.onSortChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'label': 'Mới nhất', 'sort': '-createdAt'},
      {'label': 'Giá thấp', 'sort': 'price'},
      {'label': 'Giá cao', 'sort': '-price'},
      {'label': 'Đánh giá', 'sort': '-rating'},
    ];

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.borderColor)),
      ),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = currentSort == tab['sort'];
          return Expanded(
            child: InkWell(
              onTap: () => onSortChanged(tab['sort']!),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppTheme.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    tab['label']!,
                    style: TextStyle(
                      color: isSelected ? AppTheme.primary : Colors.grey,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}