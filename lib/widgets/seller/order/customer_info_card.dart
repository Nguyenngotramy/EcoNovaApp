import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CustomerInfoCard extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final VoidCallback? onCall;
  final VoidCallback? onMessage;

  const CustomerInfoCard({
    Key? key,
    required this.name,
    required this.phone,
    required this.address,
    this.onCall,
    this.onMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Thông tin khách hàng', style: AppTheme.heading3),
              Row(
                children: [
                  if (onCall != null)
                    IconButton(
                      onPressed: onCall,
                      icon: const Icon(Icons.phone),
                      color: AppTheme.successColor,
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.successColor.withOpacity(0.1),
                      ),
                    ),
                  if (onMessage != null) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: onMessage,
                      icon: const Icon(Icons.message),
                      color: AppTheme.primary,
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.primary.withOpacity(0.1),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.person_outline, name),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.phone_outlined, phone),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.location_on_outlined, address),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: AppTheme.bodyMedium),
        ),
      ],
    );
  }
}