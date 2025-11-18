import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key}) : super(key: key);

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
          'Cà chua giàu vitamin C và chất chống oxy hóa tuyệt vời. Hỗ trợ tăng cường miễn dịch, cải thiện sức khỏe tim mạch và da. Cung cấp năng lượng tự nhiên.',
          style: AppTheme.bodyMedium,
          maxLines: isExpanded ? null : 3,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
        ),
        TextButton(
          onPressed: () => setState(() => isExpanded = !isExpanded),
          child: Text(isExpanded ? 'Thu gọn' : 'Xem thêm'),
        ),
        const Divider(height: 24),
        _buildInfoRow('Phân loại', 'Hạt', 'Vận chuyển', 'Hà Nội'),
        const SizedBox(height: 12),
        _buildInfoRow('Xuất xứ', 'Việt Nam', '', ''),
      ],
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
