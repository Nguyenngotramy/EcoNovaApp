// lib/presentation/screens/user/search/search_page.dart
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../services/product_service.dart';
import '../../../data/models/product_user.dart';
import '../../widgets/user/component/ai_button.dart';
import '../../widgets/user/component/related_products.dart';
import '../../widgets/user/search/search_header.dart';
import '../../widgets/user/search/search_result_info.dart';
import '../../widgets/user/search/search_filter_chips_horizontal.dart';
import '../../widgets/user/search/search_sort_tabs.dart';
import '../../widgets/user/search/search_product_grid.dart';
import '../../widgets/user/search/add_product_button.dart';
import '../../widgets/user/search/quick_search_tags.dart';
import '../user/product_detail_screen.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;

  const SearchPage({Key? key, this.searchQuery = ''}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Product> _products = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;

  // Filters
  String _sortBy = '-createdAt';
  String? _selectedCategory;
  double? _minPrice;
  double? _maxPrice;
  bool? _isOrganic;
  Set<String> _selectedBadges = {};

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery;
    _loadProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      if (!_isLoadingMore && _hasMore) {
        _loadMoreProducts();
      }
    }
  }

  Future<void> _loadProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        _isLoading = true;
        _products.clear();
        _currentPage = 1;
        _hasMore = true;
      });
    }

    try {
      final result = await ProductService.getProducts(
        page: _currentPage,
        limit: 20,
        search: _searchController.text.isNotEmpty ? _searchController.text : null,
        category: _selectedCategory,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        isOrganic: _isOrganic,
        badges: _selectedBadges.isNotEmpty ? _selectedBadges.join(',') : null,
        sort: _sortBy,
      );

      final List<dynamic> productsJson = result['products'] ?? [];
      final newProducts = productsJson
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();

      setState(() {
        if (isRefresh) {
          _products = newProducts;
        } else {
          _products.addAll(newProducts);
        }
        _hasMore = newProducts.length >= 20;
        _isLoading = false;
      });
    } catch (e) {
      print('Load products error: $e');
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loadMoreProducts() async {
    setState(() => _isLoadingMore = true);
    _currentPage++;
    await _loadProducts();
    setState(() => _isLoadingMore = false);
  }

  void _handleSearch(String query) {
    _loadProducts(isRefresh: true);
  }

  void _handleSortChanged(String sortBy) {
    setState(() => _sortBy = sortBy);
    _loadProducts(isRefresh: true);
  }

  void _clearFilters() {
    setState(() {
      _minPrice = null;
      _maxPrice = null;
      _isOrganic = null;
      _selectedBadges.clear();
      _selectedCategory = null;
    });
    _loadProducts(isRefresh: true);
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterBottomSheet(
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        isOrganic: _isOrganic,
        selectedBadges: _selectedBadges,
        onApply: (minPrice, maxPrice, isOrganic, badges) {
          setState(() {
            _minPrice = minPrice;
            _maxPrice = maxPrice;
            _isOrganic = isOrganic;
            _selectedBadges = badges;
          });
          _loadProducts(isRefresh: true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build activeFilters map dynamically
    Map<String, VoidCallback> activeFilters = {};
    if (_isOrganic == true) {
      activeFilters['Organic'] = () {
        setState(() => _isOrganic = null);
        _loadProducts(isRefresh: true);
      };
    }
    for (String badge in _selectedBadges) {
      activeFilters[badge] = () {
        setState(() => _selectedBadges.remove(badge));
        _loadProducts(isRefresh: true);
      };
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            SearchHeader(
              initialQuery: widget.searchQuery,
              onSearch: _handleSearch,
              onFilter: _showFilterDialog,
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchResultInfo(
                            query: _searchController.text,
                            count: _products.length,
                          ),
                          const SizedBox(height: 12),
                          if (_isOrganic != null || _selectedBadges.isNotEmpty)
                            SearchFilterChipsHorizontal(
                              activeFilters: activeFilters,
                              onClear: _clearFilters,
                            ),
                          const SizedBox(height: 16),
                          SearchSortTabs(
                            currentSort: _sortBy,
                            onSortChanged: _handleSortChanged,
                          ),
                          const SizedBox(height: 16),
                          SearchProductGrid(
                            products: _products,
                            isLoadingMore: _isLoadingMore,
                          ),
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
      floatingActionButton: const AI_Button(),
    );
  }
}

// Filter Bottom Sheet (internal component)
class _FilterBottomSheet extends StatefulWidget {
  final double? minPrice;
  final double? maxPrice;
  final bool? isOrganic;
  final Set<String> selectedBadges;
  final Function(double?, double?, bool?, Set<String>) onApply;

  const _FilterBottomSheet({
    required this.minPrice,
    required this.maxPrice,
    required this.isOrganic,
    required this.selectedBadges,
    required this.onApply,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  late bool? _isOrganic;
  late Set<String> _selectedBadges;

  final List<String> _availableBadges = ['VietGAP', 'Organic', 'Fresh', 'Premium'];

  @override
  void initState() {
    super.initState();
    _minPriceController = TextEditingController(
      text: widget.minPrice?.toStringAsFixed(0) ?? '',
    );
    _maxPriceController = TextEditingController(
      text: widget.maxPrice?.toStringAsFixed(0) ?? '',
    );
    _isOrganic = widget.isOrganic;
    _selectedBadges = Set.from(widget.selectedBadges);
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(24),
        child: ListView(
          controller: scrollController,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bộ lọc', style: AppTheme.heading3),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Khoảng giá', style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Từ',
                      border: OutlineInputBorder(),
                      suffixText: 'đ',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Đến',
                      border: OutlineInputBorder(),
                      suffixText: 'đ',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Chỉ hiện sản phẩm Organic'),
              value: _isOrganic ?? false,
              onChanged: (value) => setState(() => _isOrganic = value),
            ),
            const SizedBox(height: 16),
            Text('Nhãn hiệu', style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
            Wrap(
              spacing: 8,
              children: _availableBadges.map((badge) {
                final isSelected = _selectedBadges.contains(badge);
                return FilterChip(
                  label: Text(badge),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedBadges.add(badge);
                      } else {
                        _selectedBadges.remove(badge);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final minPrice = double.tryParse(_minPriceController.text);
                  final maxPrice = double.tryParse(_maxPriceController.text);
                  widget.onApply(minPrice, maxPrice, _isOrganic, _selectedBadges);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Áp dụng',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}