// lib/presentation/widgets/user/productdetail/product_description.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/product_user.dart';

class ProductDescription extends StatefulWidget {
  final String detailedDescription;
  final String? origin;
  final String? storageInstructions;
  final int? shelfLife;
  final NutritionInfo? nutritionInfo;

  const ProductDescription({
    Key? key,
    required this.detailedDescription,
    this.origin,
    this.storageInstructions,
    this.shelfLife,
    this.nutritionInfo,
  }) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mô tả sản phẩm', style: AppTheme.heading3),
        const SizedBox(height: 12),
        Text(
          widget.detailedDescription,
          style: AppTheme.bodyMedium,
          maxLines: isExpanded ? null : 3,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
        ),
        TextButton(
          onPressed: () => setState(() => isExpanded = !isExpanded),
          child: Text(isExpanded ? 'Thu gọn' : 'Xem thêm'),
        ),
        if (widget.nutritionInfo != null) ...[
          const SizedBox(height: 16),
          Text('Thông tin dinh dưỡng', style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          _buildNutritionRow('Calo', widget.nutritionInfo!.calories ?? 'N/A'),
          _buildNutritionRow('Protein', widget.nutritionInfo!.protein ?? 'N/A'),
          _buildNutritionRow('Carb', widget.nutritionInfo!.carbs ?? 'N/A'),
          _buildNutritionRow('Chất béo', widget.nutritionInfo!.fat ?? 'N/A'),
          _buildNutritionRow('Chất xơ', widget.nutritionInfo!.fiber ?? 'N/A'),
          _buildNutritionRow('Vitamin', widget.nutritionInfo!.vitamins ?? 'N/A'),
        ],
        const Divider(height: 24),
        _buildInfoRow('Xuất xứ', widget.origin ?? 'N/A', 'Hạn sử dụng', '${widget.shelfLife ?? 'N/A'} ngày'),
        if (widget.storageInstructions != null) ...[
          const SizedBox(height: 12),
          _buildInfoRow('Hướng dẫn bảo quản', widget.storageInstructions!, '', ''),
        ],
      ],
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.bodySmall),
          Text(value, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label1, String value1, String label2, String value2) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label1, style: AppTheme.bodySmall),
              Text(value1, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        if (label2.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label2, style: AppTheme.bodySmall),
                Text(value2, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
      ],
    );
  }
}