import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterTap;
  final String? selectedCategory;

  const SearchFilterBar({
    Key? key,
    required this.searchController,
    required this.onFilterTap,
    this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sản phẩm...',
              prefixIcon: const Icon(Icons.search, color: AppTheme.textLight),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppTheme.textLight),
                      onPressed: () => searchController.clear(),
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: selectedCategory != null ? AppTheme.primary : AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selectedCategory != null ? AppTheme.primary : AppTheme.borderColor,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.filter_list,
              color: selectedCategory != null ? AppTheme.background : AppTheme.primary,
            ),
            onPressed: onFilterTap,
          ),
        ),
      ],
    );
  }
}
