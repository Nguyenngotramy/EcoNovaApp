import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/order_model.dart';
import 'auth_service.dart';

class OrderService {
  static const String baseUrl = 'http://192.168.1.144:5000/api';

  /// ===============================
  /// CREATE ORDER
  /// ===============================
  static Future<void> createOrder({
    required String token,
    required Map<String, dynamic> deliveryInfo,
    required String deliveryMethod,
    required String paymentMethod,
    String? promoCode,
    required List<Map<String, dynamic>> products,
    required int subtotal,
    required int shippingFee,
    required int discount,
    required int total,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'deliveryInfo': deliveryInfo,
        'deliveryMethod': deliveryMethod,
        'paymentMethod': paymentMethod,
        'promoCode': promoCode,
        'products': products,
        'subtotal': subtotal,
        'shippingFee': shippingFee,
        'discount': discount,
        'total': total,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception(
        jsonDecode(response.body)['error'] ?? 'Create order failed',
      );
    }
  }

  /// ===============================
  /// GET ORDERS
  /// ===============================
   static Future<List<Order>> getOrders() async {
    final token = await AuthService.getToken();
    

    if (token == null) {
      throw Exception('User not logged in');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      print("Data nà: $data");
      return data.map((e) => Order.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
