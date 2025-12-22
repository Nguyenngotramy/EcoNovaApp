import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DeliveryMethodDialog extends StatefulWidget {
  final String currentMethod;

  const DeliveryMethodDialog({
    Key? key,
    required this.currentMethod,
  }) : super(key: key);

  @override
  State<DeliveryMethodDialog> createState() => _DeliveryMethodDialogState();
}

class _DeliveryMethodDialogState extends State<DeliveryMethodDialog> {
  late String selectedMethod;

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.currentMethod;
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
                const Text('Chọn phương thức giao hàng', style: AppTheme.heading3),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Standard Delivery
            _buildDeliveryOption(
              value: 'standard',
              icon: Icons.local_shipping,
              title: 'Giao hàng tiêu chuẩn',
              subtitle: 'Dự kiến: 20 - 30 phút',
              price: 'Miễn phí',
              color: Colors.amber,
            ),
            const SizedBox(height: 12),
            
            // Express Delivery
            _buildDeliveryOption(
              value: 'express',
              icon: Icons.electric_bolt,
              title: 'Giao hàng hỏa tốc',
              subtitle: 'Dự kiến: 10 - 15 phút',
              price: '25.000₫',
              color: Colors.red,
            ),
            
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, selectedMethod),
                child: const Text('Xác nhận'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption({
    required String value,
    required IconData icon,
    required String title,
    required String subtitle,
    required String price,
    required Color color,
  }) {
    final isSelected = selectedMethod == value;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = value),
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
                    title,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppTheme.caption),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: price == 'Miễn phí' ? AppTheme.successColor : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppTheme.successColor, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}