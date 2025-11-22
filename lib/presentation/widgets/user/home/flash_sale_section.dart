import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.secondaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FLASH SALE', style: AppTheme.heading3),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Kết thúc trong', style: AppTheme.bodySmall),
              const SizedBox(width: 8),
              _buildTimeBox('02'),
              const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildTimeBox('54'),
              const Text(' : ', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildTimeBox('30'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        time,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}