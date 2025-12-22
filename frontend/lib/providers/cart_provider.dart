import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  String? _userId;

  Map<String, CartItem> get items => _items;

  double get subtotal {
    return _items.values.fold(
      0,
      (sum, item) => sum + item.price * item.quantity,
    );
  }

  // GÁN USER SAU KHI LOGIN
  void setUser(String? userId) {
    _userId = userId;
    if (_userId != null) {
      loadCart();
    }
  }

  // ADD PRODUCT
  void addToCart(CartItem item) {
    if (_items.containsKey(item.productId)) {
      _items[item.productId]!.quantity++;
    } else {
      _items[item.productId] = item;
    }
    saveCart();
    notifyListeners();
  }

  // UPDATE QUANTITY
  void updateQuantity(String productId, int change) {
    if (!_items.containsKey(productId)) return;

    _items[productId]!.quantity += change;

    if (_items[productId]!.quantity <= 0) {
      _items.remove(productId);
    }

    saveCart();
    notifyListeners();
  }

  // REMOVE ITEM
  void removeItem(String productId) {
    _items.remove(productId);
    saveCart();
    notifyListeners();
  }

  // SAVE CART
  Future<void> saveCart() async {
    if (_userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(
      _items.values.map((e) => e.toJson()).toList(),
    );

    prefs.setString('cart_$_userId', data);
  }

  // LOAD CART
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('cart_$_userId');
    if (data == null) return;

    final List list = jsonDecode(data);
    _items.clear();

    for (var e in list) {
      final item = CartItem.fromJson(e);
      _items[item.productId] = item;
    }
    notifyListeners();
  }

  // CLEAR CART 
  Future<void> clearCart() async {
    if(_userId == null) return;
    _items.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart_$_userId');
    notifyListeners();
  }
}
