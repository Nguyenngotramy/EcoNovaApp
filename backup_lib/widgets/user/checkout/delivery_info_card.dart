import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class DeliveryInfoCard extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  final VoidCallback onEdit;

  const DeliveryInfoCard({
    Key? key,
    required this.name,
    required this.address,
    required this.phone,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppTheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: AppTheme.bodyMedium),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onEdit,
                      child: const Text(
                        'Thay đổi',
                        style: TextStyle(color: AppTheme.primary, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(address, style: AppTheme.bodySmall),
                const SizedBox(height: 4),
                Text(phone, style: AppTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}