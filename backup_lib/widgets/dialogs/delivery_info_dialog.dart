import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DeliveryInfoDialog extends StatelessWidget {
  final String name;
  final String phone;
  final String address;

  const DeliveryInfoDialog({
    Key? key,
    required this.name,
    required this.phone,
    required this.address,
  }) : super(key: key);

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
            const Text('Thông tin giao hàng', style: AppTheme.heading3),
            const SizedBox(height: 20),
            _buildInfoRow(Icons.person, name),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.phone, phone),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, address),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Xác nhận'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: AppTheme.bodyMedium),
        ),
      ],
    );
  }
}
