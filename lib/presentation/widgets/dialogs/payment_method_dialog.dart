import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/data/datasources/mock_data.dart';
import 'package:eco_nova_app/data/models/payment_method.dart';
import 'package:flutter/material.dart';
class PaymentMethodDialog extends StatefulWidget {
  final String? currentMethod;

  const PaymentMethodDialog({Key? key, this.currentMethod}) : super(key: key);

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {
  String? selectedMethodId;

  @override
  void initState() {
    super.initState();
    selectedMethodId = widget.currentMethod;
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
            const Text('Phương thức thanh toán', style: AppTheme.heading3),
            const SizedBox(height: 16),
            ...mockPaymentMethods.map((method) => _buildMethodItem(method)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, selectedMethodId),
                child: const Text('Xác nhận'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodItem(PaymentMethod method) {
    final isSelected = selectedMethodId == method.id;
    return GestureDetector(
      onTap: () => setState(() => selectedMethodId = method.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
            Text(method.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(method.name, style: AppTheme.bodyMedium),
            ),
            Radio<String>(
              value: method.id,
              groupValue: selectedMethodId,
              onChanged: (value) => setState(() => selectedMethodId = value),
              activeColor: AppTheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}