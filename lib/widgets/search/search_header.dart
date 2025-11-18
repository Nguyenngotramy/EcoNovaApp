import 'package:flutter/material.dart';
import 'dart:async';  // Thêm cho Timer debounce
import '../../theme/app_theme.dart';

class SearchHeader extends StatefulWidget {
  final String initialQuery;
  final int cartCount;  // Thêm prop dynamic cho badge
  final Function(String)? onSearchChanged;  // Callback để parent xử lý search

  const SearchHeader({
    Key? key,
    this.initialQuery = '',
    this.cartCount = 0,
    this.onSearchChanged,
  }) : super(key: key);

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  late TextEditingController _searchController;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;  // Thêm debounce timer

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    // Listener với debounce: Chờ 300ms sau khi ngừng gõ
    _searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    _debounce?.cancel();  // Hủy timer cũ
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (widget.onSearchChanged != null) {
        widget.onSearchChanged!(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();  // Cleanup timer
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
            onPressed: () {
              // Sửa: Check có thể pop không
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => _focusNode.requestFocus(),  // Tap để focus TextField
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
               
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        style: AppTheme.bodyMedium?.copyWith(color: AppTheme.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm sản phẩm...',
                          hintStyle: const TextStyle(color: AppTheme.textLight),
                          border: InputBorder.none,
                          isDense: true,
                          // Thêm clear button khi có text
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    _searchController.clear();
                                    if (widget.onSearchChanged != null) {
                                      widget.onSearchChanged!('');
                                    }
                                  },
                                )
                              : null,
                        ),
                        onSubmitted: (query) {
                          if (widget.onSearchChanged != null) {
                            widget.onSearchChanged!(query);
                          }
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Voice search - Add package: flutter pub add speech_to_text
                        // Sau đó: import 'package:speech_to_text/speech_to_text.dart';
                        // SpeechToText _speech = SpeechToText();
                        // _speech.listen(onResult: (result) => _searchController.text = result.recognizedWords);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Voice search sắp ra mắt!')),
                        );
                      },
                      child: const Icon(Icons.mic, color: AppTheme.primary, size: 22),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _showFilterDialog(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.tune, color: AppTheme.primary, size: 22),
            ),
          ),
          const SizedBox(width: 8),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 26),
                onPressed: () {
                  // TODO: Navigate - Navigator.pushNamed(context, '/cart');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Chuyển đến giỏ hàng')),
                  );
                },
                color: AppTheme.primary,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              if (widget.cartCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text(
                      '${widget.cartCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    // State đơn giản cho filter (có thể dùng Provider cho phức tạp hơn)
    bool _electronics = false;
    bool _clothing = false;
    double _minPrice = 0;
    double _maxPrice = 1000;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(  // Để update state trong dialog
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Lọc tìm kiếm'),
          content: SingleChildScrollView(  // Scroll nếu nhiều options
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: const Text('Điện tử'),
                  value: _electronics,
                  onChanged: (value) => setDialogState(() => _electronics = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                CheckboxListTile(
                  title: const Text('Thời trang'),
                  value: _clothing,
                  onChanged: (value) => setDialogState(() => _clothing = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const Divider(),
                const Text('Giá (VND):'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Tối thiểu'),
                        onChanged: (value) => _minPrice = double.tryParse(value) ?? 0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Tối đa'),
                        onChanged: (value) => _maxPrice = double.tryParse(value) ?? 1000,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Áp dụng filter - Gọi callback hoặc update parent state
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Áp dụng filter: Điện tử ${_electronics ? 'Có' : 'Không'}, Giá $_minPrice - $_maxPrice')),
                );
              },
              child: const Text('Áp dụng'),
            ),
          ],
        ),
      ),
    );
  }
}