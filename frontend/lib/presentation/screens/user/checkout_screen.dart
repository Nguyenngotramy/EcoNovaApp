import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/cart_item.dart';
import '../../widgets/dialogs/delivery_info_dialog.dart';
import '../../widgets/dialogs/promo_code_dialog.dart';
import '../../widgets/dialogs/payment_method_dialog.dart';
import '../../widgets/dialogs/delivery_method_dialog.dart';
import '../../widgets/dialogs/success_dialog.dart';
import '../../widgets/user/cart/cart_item_card.dart';
import 'package:provider/provider.dart';
import '../../../providers/cart_provider.dart';
import '../../../services/auth_service.dart';
import '../../../services/order_service.dart';


// Import để sử dụng availablePromoCodes và DeliveryInfo
export '../../widgets/dialogs/promo_code_dialog.dart' show availablePromoCodes;
export '../../widgets/dialogs/delivery_info_dialog.dart' show DeliveryInfo;

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double subtotal;

  const CheckoutScreen({
    Key? key,
    required this.cartItems,
    required this.subtotal,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'cod';
  String selectedDeliveryMethod = 'standard';
  String? selectedPromoId;
  late List<CartItem> orderProducts;

  // Delivery info - có thể thay đổi
  String deliveryName = 'Nguyễn Văn A';
  String deliveryPhone = '0702192094';
  String deliveryAddress = '17 Hai Bà Trưng, Phường Bến Nghé, Quận 1, Tp.Hồ Chí Minh';

  @override
  void initState() {
    super.initState();
    orderProducts = List.from(widget.cartItems);
  }

  // Tính phí giao hàng gốc dựa trên phương thức giao hàng
  double get baseShippingFee {
    return selectedDeliveryMethod == 'express' ? 25000 : 0;
  }

  // Tính phí giao hàng sau khi áp dụng freeship (nếu có)
  double get finalShippingFee {
    if (selectedPromoId == null) return baseShippingFee;
    
    final promo = availablePromoCodes.firstWhere(
      (p) => p.id == selectedPromoId,
      orElse: () => availablePromoCodes[0],
    );
    
    // Kiểm tra xem có phải voucher freeship không (không phân biệt hoa thường)
    final isFreeship = promo.code.toUpperCase().contains('FREESHIP') || 
                       promo.code.toUpperCase() == 'FREESHIP';
    
    if (isFreeship) {
      // Trừ giá trị discount từ phí ship, nhưng không để âm
      final discountedFee = baseShippingFee - promo.discount;
      return discountedFee < 0 ? 0 : discountedFee;
    }
    
    return baseShippingFee;
  }

  // Tính discount cho sản phẩm (không bao gồm freeship)
  double get productDiscount {
    if (selectedPromoId == null) return 0;
    
    final promo = availablePromoCodes.firstWhere(
      (p) => p.id == selectedPromoId,
      orElse: () => availablePromoCodes[0],
    );
    
    // Kiểm tra xem có phải voucher freeship không
    final isFreeship = promo.code.toUpperCase().contains('FREESHIP') || 
                       promo.code.toUpperCase() == 'FREESHIP';
    
    // Nếu là voucher freeship, không tính vào discount sản phẩm
    if (isFreeship) {
      return 0;
    }
    
    return promo.discount;
  }

  double get total => widget.subtotal + finalShippingFee - productDiscount;

  String get selectedPromoCode {
    if (selectedPromoId == null) return 'Chọn mã';
    final promo = availablePromoCodes.firstWhere(
      (p) => p.id == selectedPromoId,
      orElse: () => availablePromoCodes[0],
    );
    return promo.code;
  }

  String get selectedPromoTitle {
    if (selectedPromoId == null) return 'Chọn mã giảm giá';
    final promo = availablePromoCodes.firstWhere(
      (p) => p.id == selectedPromoId,
      orElse: () => availablePromoCodes[0],
    );
    return promo.title;
  }

  String get paymentMethodLabel {
    switch (selectedPaymentMethod) {
      case 'cod':
        return 'Tiền mặt';
      case 'banking':
        return 'Internet Banking';
      case 'momo':
        return 'Ví Momo';
      case 'wallet':
        return 'Ví trả sau';
      default:
        return 'Tiền mặt';
    }
  }

  void removeOrderItem(String id) {
    setState(() {
      orderProducts.removeWhere((p) => p.productId == id);
    });
  }

  void addQuantity(String id) {
    setState(() {
      final index = orderProducts.indexWhere((p) => p.productId == id);
      if (index != -1) {
        orderProducts[index].quantity++;
      }
    });
  }

  void showDeliveryInfoDialog() async {
    final result = await showDialog<DeliveryInfo>(
      context: context,
      builder: (context) => DeliveryInfoDialog(
        name: deliveryName,
        phone: deliveryPhone,
        address: deliveryAddress,
      ),
    );
    
    if (result != null) {
      setState(() {
        deliveryName = result.name;
        deliveryPhone = result.phone;
        deliveryAddress = result.address;
      });
    }
  }

  // Thêm hàm này để hiển thị dialog chọn phương thức giao hàng
  void showDeliveryMethodDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) =>
          DeliveryMethodDialog(currentMethod: selectedDeliveryMethod),
    );
    if (result != null) {
      setState(() => selectedDeliveryMethod = result);
    }
  }

  void showPromoCodeDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => PromoCodeDialog(currentPromoId: selectedPromoId),
    );
    setState(() {
      selectedPromoId = result;
    });
  }

  void showPaymentMethodDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) =>
          PaymentMethodDialog(currentMethod: selectedPaymentMethod),
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

  Future<void> _handleCheckout() async {
  try {
    // 1. Lấy token
    final token = await AuthService.getToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn chưa đăng nhập')),
      );
      return;
    }

    // 2. Build products đúng backend
    final products = orderProducts.map((item) {
      return {
        'productId': item.productId,
        'price': item.price,
        'quantity': item.quantity,
      };
    }).toList();

    // 3. Gọi API create order
    await OrderService.createOrder(
      token: token,
      deliveryInfo: {
        'name': deliveryName,
        'phone': deliveryPhone,
        'address': deliveryAddress,
      },
      deliveryMethod: selectedDeliveryMethod,
      paymentMethod: selectedPaymentMethod,
      promoCode: selectedPromoId,
      products: products,
      subtotal: widget.subtotal.toInt(),
      shippingFee: finalShippingFee.toInt(),
      discount: productDiscount.toInt(),
      total: total.toInt(),
    );

    // 4. Clear cart
    context.read<CartProvider>().clearCart();

    // 5. Show success
    showSuccessDialog();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  }
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
                _buildSectionHeader('Thông tin giao hàng',
                    onTap: showDeliveryInfoDialog),
                _buildDeliveryInfoCard(),
                const SizedBox(height: 20),

                // Delivery Method
                _buildSectionHeader('Phương thức giao hàng',
                    onTap: showDeliveryMethodDialog),
                _buildDeliveryMethodCard(),
                const SizedBox(height: 20),

                // Order Items
                const Text('Sản phẩm đã chọn', style: AppTheme.heading3),
                const SizedBox(height: 12),
                ...orderProducts.map(
                  (item) => CartItemCard(
                    item: item,
                    onDelete: () {
                      context.read<CartProvider>().removeItem(item.productId);
                    },
                    onQuantityChange: (change) {
                      context
                          .read<CartProvider>()
                          .updateQuantity(item.productId, change);
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Payment Method
                _buildSectionHeader('Phương thức thanh toán',
                    onTap: showPaymentMethodDialog),
                _buildPaymentMethodCard(),
                const SizedBox(height: 20),

                // Promo Code
                _buildSectionHeader('Mã giảm giá', onTap: showPromoCodeDialog),
                _buildPromoCodeCard(),
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
            child: const Icon(Icons.check_circle,
                color: AppTheme.successColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deliveryName,
                    style: AppTheme.bodyMedium
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(deliveryAddress,
                    style: AppTheme.bodySmall, maxLines: 2),
                const SizedBox(height: 4),
                Text(deliveryPhone, style: AppTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryMethodCard() {
    final isExpress = selectedDeliveryMethod == 'express';
    final bgColor = isExpress ? Colors.red.shade50 : Colors.amber.shade50;
    final borderColor =
        isExpress ? Colors.red.shade200 : Colors.amber.shade200;
    final iconBgColor =
        isExpress ? Colors.red.shade100 : Colors.amber.shade100;
    final iconColor = isExpress ? Colors.red : Colors.amber;
    final icon = isExpress ? Icons.electric_bolt : Icons.local_shipping;
    final title = isExpress ? 'Giao hàng hỏa tốc' : 'Giao hàng tiêu chuẩn';
    final subtitle = isExpress
        ? 'Dự kiến: 10 - 15 phút • 25.000₫'
        : 'Dự kiến: 20 - 30 phút • Miễn phí giao hàng';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTheme.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    IconData paymentIcon;
    String paymentDescription;

    switch (selectedPaymentMethod) {
      case 'cod':
        paymentIcon = Icons.money;
        paymentDescription = 'COD';
        break;
      case 'banking':
        paymentIcon = Icons.account_balance;
        paymentDescription = 'Chuyển khoản ngân hàng';
        break;
      case 'momo':
        paymentIcon = Icons.wallet;
        paymentDescription = 'Ví điện tử Momo';
        break;
      case 'wallet':
        paymentIcon = Icons.credit_card;
        paymentDescription = 'Thanh toán bằng thẻ';
        break;
      default:
        paymentIcon = Icons.money;
        paymentDescription = 'Thanh toán khi nhận hàng';
    }

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
              child: Icon(paymentIcon,
                  color: AppTheme.successColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(paymentMethodLabel,
                      style: AppTheme.bodyMedium
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(paymentDescription, style: AppTheme.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCodeCard() {
    final hasPromo = selectedPromoId != null;
    final cardColor = hasPromo ? Colors.purple.shade50 : Colors.blue.shade50;
    final borderColor =
        hasPromo ? Colors.purple.shade200 : Colors.blue.shade200;
    final iconBgColor =
        hasPromo ? Colors.purple.shade100 : Colors.blue.shade100;
    final iconColor = hasPromo ? Colors.purple : Colors.blue;

    return GestureDetector(
      onTap: showPromoCodeDialog,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasPromo ? Icons.discount : Icons.local_offer,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasPromo ? selectedPromoCode : 'Chọn mã giảm giá',
                    style: AppTheme.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasPromo ? selectedPromoTitle : 'Nhấn để chọn mã ưu đãi',
                    style: AppTheme.caption,
                  ),
                ],
              ),
            ),
            if (hasPromo)
              const Icon(Icons.check_circle,
                  color: AppTheme.successColor, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    // Kiểm tra xem có đang dùng voucher freeship không
    bool isUsingFreeship = false;
    double freeshipDiscount = 0;
    
    if (selectedPromoId != null) {
      final promo = availablePromoCodes.firstWhere(
        (p) => p.id == selectedPromoId,
        orElse: () => availablePromoCodes[0],
      );
      
      final isFreeship = promo.code.toUpperCase().contains('FREESHIP') || 
                         promo.code.toUpperCase() == 'FREESHIP';
      
      if (isFreeship) {
        isUsingFreeship = true;
        freeshipDiscount = baseShippingFee - finalShippingFee;
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          _buildSummaryRow(
              'Tạm tính', '${widget.subtotal.toStringAsFixed(0)}₫'),
          const SizedBox(height: 8),
          
          // Hiển thị phí giao hàng gốc
          _buildSummaryRow(
            'Phí giao hàng',
            baseShippingFee == 0 
                ? 'Miễn phí' 
                : '${baseShippingFee.toStringAsFixed(0)}₫',
            valueColor: AppTheme.textSecondary,
          ),
          
          // Nếu có freeship, hiển thị dòng giảm giá phí ship
          if (isUsingFreeship && freeshipDiscount > 0) ...[
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Giảm phí ship',
              '-${freeshipDiscount.toStringAsFixed(0)}₫',
              valueColor: AppTheme.successColor,
            ),
          ],
          
          const SizedBox(height: 8),
          
          // Hiển thị mã giảm giá cho sản phẩm (không bao gồm freeship)
          _buildSummaryRow(
            'Mã giảm giá',
            productDiscount > 0
                ? '-${productDiscount.toStringAsFixed(0)}₫'
                : 'Chưa áp dụng',
            valueColor: productDiscount > 0
                ? AppTheme.successColor
                : AppTheme.textSecondary,
          ),
          
          const Divider(height: 24),
          _buildSummaryRow('Phương thức thanh toán', paymentMethodLabel,
              valueStyle: AppTheme.bodyMedium
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {Color? valueColor, TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTheme.bodyMedium),
        Text(
          value,
          style: valueStyle ??
              AppTheme.bodyMedium.copyWith(color: valueColor),
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
              onPressed: _handleCheckout,
              child: const Text('Thanh toán'),
            ),
          ),
        ],
      ),
    );
  }
}