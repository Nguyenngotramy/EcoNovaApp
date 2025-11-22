import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String weight;
  final String price;
  final String status;
  final Color statusColor;
  final String? deliveryTime;
  final VoidCallback onConfirm;
  final VoidCallback onReject;

  const OrderCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.weight,
    required this.price,
    required this.status,
    required this.statusColor,
    this.deliveryTime,
    required this.onConfirm,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: AppTheme.cardBackground,
                    child: const Icon(Icons.image, color: AppTheme.textLight),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productName, style: AppTheme.heading3),
                    const SizedBox(height: 4),
                    Text(
                      '$weight • $price',
                      style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
                    ),
                    if (deliveryTime != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        deliveryTime!,
                        style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: AppTheme.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirm,
                  child: const Text('Xác nhận'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textSecondary,
                    side: const BorderSide(color: AppTheme.borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Từ chối'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
