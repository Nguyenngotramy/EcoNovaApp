import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/data/datasources/mock_data.dart' show mockPromotions;
import 'package:eco_nova_app/data/models/promotion.dart';
import 'package:flutter/material.dart';
class PromoCodeDialog extends StatefulWidget {
  const PromoCodeDialog({Key? key}) : super(key: key);

  @override
  State<PromoCodeDialog> createState() => _PromoCodeDialogState();
}

class _PromoCodeDialogState extends State<PromoCodeDialog> {
  String? selectedPromoId;

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
            const Text('Mã giảm giá', style: AppTheme.heading3),
            const SizedBox(height: 16),
            ...mockPromotions.map((promo) => _buildPromoItem(promo)),
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

  Widget _buildPromoItem(Promotion promo) {
    final isSelected = selectedPromoId == promo.id;
    return GestureDetector(
      onTap: () => setState(() => selectedPromoId = promo.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.secondary.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.discount, color: Colors.amber),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(promo.title, style: AppTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(promo.description, style: AppTheme.caption),
                ],
              ),
            ),
            Radio<String>(
              value: promo.id,
              groupValue: selectedPromoId,
              onChanged: (value) => setState(() => selectedPromoId = value),
              activeColor: AppTheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}