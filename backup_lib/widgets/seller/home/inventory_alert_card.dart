import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class InventoryAlertCard extends StatelessWidget {
  final String productName;
  final String currentStock;
  final String message;
  final Color alertColor;
  final VoidCallback onAction;

  const InventoryAlertCard({
    Key? key,
    required this.productName,
    required this.currentStock,
    required this.message,
    required this.alertColor,
    required this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: alertColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: alertColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.warning_amber_rounded, color: alertColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productName, style: AppTheme.heading3),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onAction,
            child: const Text('Nhập kho'),
          ),
        ],
      ),
    );
  }
}
