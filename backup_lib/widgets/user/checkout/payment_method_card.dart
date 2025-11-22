import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class PaymentMethodCard extends StatelessWidget {
  final String value;
  final String title;
  final IconData icon;
  final bool isSelected;
  final bool showChangeButton;
  final VoidCallback onTap;
  final VoidCallback? onChangePressed;

  const PaymentMethodCard({
    Key? key,
    required this.value,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.showChangeButton = false,
    this.onChangePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.secondary.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(12),
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
                color: isSelected ? AppTheme.primary : AppTheme.cardBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppTheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (showChangeButton)
              GestureDetector(
                onTap: onChangePressed,
                child: const Text(
                  'Thay đổi',
                  style: TextStyle(color: AppTheme.primary, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}