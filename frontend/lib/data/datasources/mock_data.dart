


import '../models/product.dart';
import '../models/promotion.dart';
import '../models/payment_method.dart';

final List<Product> mockCartProducts = [
  Product(
    id: '1',
    name: 'Cà chua bi organic',
    image: '🍅',
    price: 45000,
    unit: 'kg',
    quantity: 1,
  ),
  Product(
    id: '2',
    name: 'Khoai tây',
    image: '🥔',
    price: 45000,
    unit: 'kg',
    quantity: 1,
  ),
  Product(
    id: '3',
    name: 'Rau xà lách',
    image: '🥬',
    price: 45000,
    unit: 'kg',
    quantity: 1,
  ),
  Product(
    id: '4',
    name: 'Cà chua bi organic',
    image: '🍅',
    price: 45000,
    unit: 'kg',
    quantity: 1,
  ),
];

final List<Promotion> mockPromotions = [
  Promotion(
    id: '1',
    title: 'Giảm 20.000đ cho khách hàng mới',
    description: 'Hết số lượng: 07/10/2025',
    discount: '20.000đ',
    expiry: '07/10/2025',
  ),
  Promotion(
    id: '2',
    title: 'Giảm 20.000đ cho khách hàng mới',
    description: 'Hết số lượng: 30/10/2025',
    discount: '20.000đ',
    expiry: '30/10/2025',
  ),
  Promotion(
    id: '3',
    title: 'Giảm 20.000đ cho khách hàng mới',
    description: 'Hết số lượng: 07/10/2025',
    discount: '20.000đ',
    expiry: '07/10/2025',
  ),
];

final List<PaymentMethod> mockPaymentMethods = [
  PaymentMethod(
    id: 'cod',
    name: 'Thanh toán khi nhận hàng (COD)',
    icon: '💵',
  ),
  PaymentMethod(
    id: 'banking',
    name: 'Internet Banking',
    icon: '🏦',
  ),
  PaymentMethod(
    id: 'momo',
    name: 'Momo',
    icon: '🎀',
  ),
  PaymentMethod(
    id: 'wallet',
    name: 'Thẻ tín dụng',
    icon: '💳',
  ),
];