import 'package:eco_nova_app/widgets/ai_button.dart';
import 'package:eco_nova_app/widgets/related_products.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/search/search_header.dart';
import '../widgets/search/search_result_info.dart';
import '../widgets/search/search_filter_chips_horizontal.dart';
import '../widgets/search/search_sort_tabs.dart';
import '../widgets/search/search_product_card.dart';
import '../widgets/search/add_product_button.dart';
import '../widgets/search/quick_search_tags.dart';

class SearchPage extends StatelessWidget {
  final String searchQuery;

  const SearchPage({Key? key, this.searchQuery = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            SearchHeader(initialQuery: searchQuery),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchResultInfo(query: searchQuery, count: 13),
                    const SizedBox(height: 12),
                    const SearchFilterChipsHorizontal(),
                    const SizedBox(height: 16),
                    const SearchSortTabs(),
                    const SizedBox(height: 16),
                    const SearchProductGrid(),
                    const SizedBox(height: 16),
                    const AddProductButton(),
                    const SizedBox(height: 24),
                    const RelatedProducts(),
                    const SizedBox(height: 24),
                    const QuickSearchTags(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AI_Button(),
    );
  }
}

