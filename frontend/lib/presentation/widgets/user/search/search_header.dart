// lib/presentation/widgets/user/search/search_header.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SearchHeader extends StatelessWidget {
  final String initialQuery;
  final Function(String) onSearch;
  final VoidCallback onFilter;

  const SearchHeader({
    Key? key,
    this.initialQuery = '',
    required this.onSearch,
    required this.onFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: initialQuery);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(21),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            controller.clear();
                            onSearch('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: onSearch,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilter,
          ),
        ],
      ),
    );
  }
}