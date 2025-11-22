import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dialogs/delivery_info_dialog.dart';
import '../../widgets/dialogs/promo_code_dialog.dart';
import '../../widgets/dialogs/payment_method_dialog.dart';
import '../../widgets/dialogs/success_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cartProducts;
  final double subtotal;

  const CheckoutScreen({
    Key? key,
    required this.cartProducts,
    required this.subtotal,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'cod';
  String? selectedPromoId;
  late List<Product> orderProducts;

  final double shippingFee = 10000;
  final double discount = 10000;

  // Delivery info
  final String deliveryName = 'Nguyễn Văn A';
  final String deliveryPhone = '0702192094';
  final String deliveryAddress = '17 Hai Bà Trưng, Phường Bến Nghé, Quận 1, Tp.Hồ Chí Minh';

  @override
  void initState() {
    super.initState();
    orderProducts = List.from(widget.cartProducts);
  }

  double get total => widget.subtotal + shippingFee - discount;

  String get paymentMethodLabel {
    switch (selectedPaymentMethod) {
      case 'cod':
        return 'COD';
      case 'banking':
        return 'Internet Banking';
      case 'momo':
        return 'Momo';
      case 'wallet':
        return 'Thẻ tín dụng';
      default:
        return 'COD';
    }
  }

  void removeOrderItem(String id) {
    setState(() {
      orderProducts.removeWhere((p) => p.id == id);
    });
  }

  void addQuantity(String id) {
    setState(() {
      final index = orderProducts.indexWhere((p) => p.id == id);
      if (index != -1) {
        orderProducts[index].quantity++;
      }
    });
  }

  void showDeliveryInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => DeliveryInfoDialog(
        name: deliveryName,
        phone: deliveryPhone,
        address: deliveryAddress,
      ),
    );
  }

  void showPromoCodeDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const PromoCodeDialog(),
    );
    if (result != null) {
      setState(() => selectedPromoId = result);
    }
  }

  void showPaymentMethodDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => PaymentMethodDialog(currentMethod: selectedPaymentMethod),
    );
    if (result != null) {
      setState(() => selectedPaymentMethod = result);
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SuccessDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Thanh toán', style: AppTheme.heading3),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Delivery Info
                _buildSectionHeader('Thông tin giao hàng', onTap: showDeliveryInfoDialog),
                _buildDeliveryInfoCard(),
                const SizedBox(height: 20),

                // Promo Code
                _buildSectionHeader('Giao hàng tiêu chuẩn', onTap: () {}),
                _buildPromoCodeCard(),
                const SizedBox(height: 20),

                // Order Items
                const Text('Sản phẩm đã chọn', style: AppTheme.heading3),
                const SizedBox(height: 12),
                ...orderProducts.map((product) => _buildOrderItemCard(product)),
                const SizedBox(height: 20),

                // Payment Method
                _buildSectionHeader('Phương thức thanh toán', onTap: showPaymentMethodDialog),
                _buildPaymentMethodCard(),
                const SizedBox(height: 20),

                // Order Summary
                const Text('Chi tiết đơn hàng', style: AppTheme.heading3),
                const SizedBox(height: 12),
                _buildOrderSummary(),
              ],
            ),
          ),
          _buildBottomSummary(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTheme.heading3),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: const Text('Thay đổi', style: TextStyle(fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildDeliveryInfoCard() {
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
              color: AppTheme.successColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle, color: AppTheme.successColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deliveryName, style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(deliveryAddress, style: AppTheme.bodySmall, maxLines: 2),
                const SizedBox(height: 4),
                Text(deliveryPhone, style: AppTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
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
            child: const Icon(Icons.local_shipping, color: Colors.amber),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Giao hàng tiêu chuẩn', style: AppTheme.bodyMedium),
                SizedBox(height: 4),
                Text('Dự kiến: 30 - 35 phút • Miễn phí giao hàng', style: AppTheme.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemCard(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text(product.image, style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: AppTheme.bodyMedium),
                const SizedBox(height: 4),
                Text('${product.price.toStringAsFixed(0)}₫', style: AppTheme.price),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppTheme.errorColor, size: 20),
            onPressed: () => removeOrderItem(product.id),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('${product.quantity}', style: AppTheme.bodyMedium),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => addQuantity(product.id),
            child: const Icon(Icons.add_circle, color: AppTheme.primary, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return GestureDetector(
      onTap: showPaymentMethodDialog,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.successColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.successColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: AppTheme.successColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Giao hàng tiêu chuẩn', style: AppTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text('Dự kiến: 30 - 35 phút • Miễn phí giao hàng', style: AppTheme.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Tạm tính', '${widget.subtotal.toStringAsFixed(0)}₫'),
          const SizedBox(height: 8),
          _buildSummaryRow('Phí giao hàng', '${shippingFee.toStringAsFixed(0)}₫',
              valueColor: AppTheme.textSecondary),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: showPromoCodeDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Mã giảm giá', style: AppTheme.bodyMedium),
                Text('Chọn mã', style: TextStyle(color: AppTheme.primary, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _buildSummaryRow('Giảm giá', '-${discount.toStringAsFixed(0)}₫',
              valueColor: AppTheme.successColor),
          const Divider(height: 24),
          _buildSummaryRow('Phương thức thanh toán', paymentMethodLabel,
              valueStyle: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor, TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTheme.bodyMedium),
        Text(
          value,
          style: valueStyle ?? AppTheme.bodyMedium.copyWith(color: valueColor),
        ),
      ],
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng cộng', style: AppTheme.heading3),
              Text(
                '${total.toStringAsFixed(0)}₫',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: showSuccessDialog,
              child: const Text('Thanh toán'),
            ),
          ),
        ],
      ),
    );
  }
}