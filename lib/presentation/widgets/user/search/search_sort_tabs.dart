import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchSortTabs extends StatefulWidget {
  const SearchSortTabs({Key? key}) : super(key: key);

  @override
  State<SearchSortTabs> createState() => _SearchSortTabsState();
}

class _SearchSortTabsState extends State<SearchSortTabs> {
  int _selectedIndex = 0;
  final List<String> _tabs = ['Phù hợp\nnhất', 'Giá thấp', 'Giá Cao', 'Đánh giá'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Sắp xếp theo:',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: List.generate(_tabs.length, (index) {
                return Expanded(
                  child: _buildTab(_tabs[index], index),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = index == _selectedIndex;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppTheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTheme.bodySmall.copyWith(
            color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}