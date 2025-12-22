import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/user/cart/cart_item_card.dart';
import '../../widgets/user/cart/promotion_card.dart';
import 'package:provider/provider.dart';
import '../../../providers/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items.values.toList();

    const double freeShippingThreshold = 200000;
    const double shippingFee = 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            const Text('Giỏ hàng', style: AppTheme.heading3),
            Text('${items.length} sản phẩm', style: AppTheme.caption),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...items.map(
                  (item) => CartItemCard(
                    item: item,
                    onDelete: () {
                      context
                          .read<CartProvider>()
                          .removeItem(item.productId);
                    },
                    onQuantityChange: (change) {
                      context
                          .read<CartProvider>()
                          .updateQuantity(item.productId, change);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                PromotionCard(
                  currentAmount: cart.subtotal,
                  targetAmount: freeShippingThreshold,
                ),
              ],
            ),
          ),
          _buildBottomSummary(context, cart, shippingFee),
        ],
      ),
    );
  }

  Widget _buildBottomSummary(
    BuildContext context,
    CartProvider cart,
    double shippingFee,
  ) {
    final total = cart.subtotal + shippingFee;

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
              Text(
                'Tạm tính (${cart.items.length} sản phẩm)',
                style: AppTheme.bodyMedium,
              ),
              Text(
                '${cart.subtotal.toStringAsFixed(0)}₫',
                style: AppTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phí vận chuyển', style: AppTheme.bodyMedium),
              Text(
                shippingFee == 0 ? 'Miễn phí' : '${shippingFee}₫',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.successColor,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng cộng', style: AppTheme.heading3),
              Text(
                '${total.toStringAsFixed(0)}₫',
                style: AppTheme.heading2.copyWith(color: AppTheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: cart.items.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(
                            cartItems: cart.items.values.toList(),
                            subtotal: cart.subtotal,
                          ),
                        ),
                      );
                    },
              child: const Text('Tiến hành đặt hàng'),
            ),
          ),
        ],
      ),
    );
  }
}
