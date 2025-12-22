import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PromoCode {
  final String id;
  final String code;
  final String title;
  final double discount;
  final String description;

  PromoCode({
    required this.id,
    required this.code,
    required this.title,
    required this.discount,
    required this.description,
  });
}

// Danh sách mã giảm giá mẫu
final List<PromoCode> availablePromoCodes = [
  PromoCode(
    id: 'promo1',
    code: 'GIAM10K',
    title: 'Giảm 10.000₫',
    discount: 10000,
    description: 'Áp dụng cho đơn hàng từ 50.000₫',
  ),
  PromoCode(
    id: 'promo2',
    code: 'GIAM20K',
    title: 'Giảm 20.000₫',
    discount: 20000,
    description: 'Áp dụng cho đơn hàng từ 100.000₫',
  ),
  PromoCode(
    id: 'promo3',
    code: 'GIAM50K',
    title: 'Giảm 50.000₫',
    discount: 50000,
    description: 'Áp dụng cho đơn hàng từ 200.000₫',
  ),
  PromoCode(
    id: 'promo4',
    code: 'FREESHIP',
    title: 'Miễn phí vận chuyển',
    discount: 25000, // Giảm tối đa 25.000₫ phí ship
    description: 'Áp dụng cho mọi đơn hàng',
  ),
];

class PromoCodeDialog extends StatefulWidget {
  final String? currentPromoId;

  const PromoCodeDialog({Key? key, this.currentPromoId}) : super(key: key);

  @override
  State<PromoCodeDialog> createState() => _PromoCodeDialogState();
}

class _PromoCodeDialogState extends State<PromoCodeDialog> {
  String? selectedPromoId;

  @override
  void initState() {
    super.initState();
    selectedPromoId = widget.currentPromoId;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Chọn mã giảm giá', style: AppTheme.heading3),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Không áp dụng mã
            _buildPromoOption(
              id: null,
              icon: Icons.cancel_outlined,
              code: 'KHÔNG SỬ DỤNG',
              title: 'Không áp dụng mã',
              description: 'Bỏ qua mã giảm giá',
              discount: 0,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            
            // Danh sách mã giảm giá
            ...availablePromoCodes.map((promo) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildPromoOption(
                id: promo.id,
                icon: Icons.discount,
                code: promo.code,
                title: promo.title,
                description: promo.description,
                discount: promo.discount,
                color: _getPromoColor(promo.discount),
              ),
            )),
            
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, selectedPromoId),
                child: const Text('Xác nhận'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPromoColor(double discount) {
    if (discount >= 50000) return Colors.purple;
    if (discount >= 20000) return Colors.orange;
    if (discount >= 10000) return Colors.blue;
    return Colors.green;
  }

  Widget _buildPromoOption({
    required String? id,
    required IconData icon,
    required String code,
    required String title,
    required String description,
    required double discount,
    required Color color,
  }) {
    final isSelected = selectedPromoId == id;
    return GestureDetector(
      onTap: () => setState(() => selectedPromoId = id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppTheme.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(title, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(description, style: AppTheme.caption),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.successColor, size: 24),
          ],
        ),
      ),
    );
  }
}