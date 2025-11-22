import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchFilterChipsHorizontal extends StatefulWidget {
  const SearchFilterChipsHorizontal({Key? key}) : super(key: key);

  @override
  State<SearchFilterChipsHorizontal> createState() => _SearchFilterChipsHorizontalState();
}

class _SearchFilterChipsHorizontalState extends State<SearchFilterChipsHorizontal> {
  final List<String> _filters = ['Hoàn thành', 'organic', 'Đà Lạt', '<10km'];
  final List<bool> _selected = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return FilterChipItem(
            label: _filters[index],
            isSelected: _selected[index],
            onTap: () {
              setState(() {
                _selected[index] = !_selected[index];
              });
            },
          );
        },
      ),
    );
  }
}

class FilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipItem({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.borderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(Icons.check, size: 16, color: Colors.white),
              ),
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                color: isSelected ? Colors.white : AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
