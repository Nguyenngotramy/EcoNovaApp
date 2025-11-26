
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/datasources/mock_data.dart';
import '../../../data/models/product.dart';
import '../../widgets/user/cart/cart_item_card.dart';
import '../../widgets/user/cart/promotion_card.dart';
import '../../widgets/user/cart/related_product_card.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> cartProducts = List.from(mockCartProducts);
  double shippingFee = 0;
  final double freeShippingThreshold = 200000;

  double get subtotal {
    return cartProducts.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get total => subtotal + shippingFee;

  void updateQuantity(String id, int change) {
    setState(() {
      final index = cartProducts.indexWhere((p) => p.id == id);
      if (index != -1) {
        cartProducts[index].quantity += change;
        if (cartProducts[index].quantity <= 0) {
          cartProducts.removeAt(index);
        }
      }
    });
  }

  void removeItem(String id) {
    setState(() {
      cartProducts.removeWhere((p) => p.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            const Text('Giỏ hàng', style: AppTheme.heading3),
            Text('${cartProducts.length} sản phẩm', style: AppTheme.caption),
          ],
        ),
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
                ...cartProducts.map((product) => CartItemCard(
                  product: product,
                  onDelete: () => removeItem(product.id),
                  onQuantityChange: (change) => updateQuantity(product.id, change),
                )),
                const SizedBox(height: 16),
                PromotionCard(
                  currentAmount: subtotal,
                  targetAmount: freeShippingThreshold,
                ),
                const SizedBox(height: 16),
                const Text('Có thể bạn quan tâm', style: AppTheme.heading3),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      RelatedProductCard(
                        name: 'Cà chua bi organic',
                        image: '🍅',
                        price: 45000,
                        unit: 'kg',
                        rating: 4.8,
                        distance: '1.6km',
                        discount: 10,
                        onAddToCart: () {},
                      ),
                      RelatedProductCard(
                        name: 'Cà chua bi organic',
                        image: '🍅',
                        price: 45000,
                        unit: 'kg',
                        rating: 4.8,
                        distance: '1.6km',
                        discount: 10,
                        onAddToCart: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildBottomSummary(),
        ],
      ),
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
              Text('Tạm tính (${cartProducts.length} sản phẩm)', style: AppTheme.bodyMedium),
              Text('${subtotal.toStringAsFixed(0)}₫', style: AppTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phí vận chuyển', style: AppTheme.bodyMedium),
              Text(
                shippingFee == 0 ? 'Miễn phí' : '${shippingFee.toStringAsFixed(0)}₫',
                style: AppTheme.bodyMedium.copyWith(color: AppTheme.successColor),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      cartProducts: cartProducts,
                      subtotal: subtotal,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_bag_outlined, size: 20),
                  SizedBox(width: 8),
                  Text('Tiến hành đặt hàng'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}