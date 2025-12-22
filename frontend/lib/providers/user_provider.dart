import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  Map<String, dynamic>? _user; // null = chưa login

  Map<String, dynamic>? get user => _user;

  ///  Kiểm tra nhanh trạng thái login
  bool get isLoggedIn => _user != null;

  /// Lấy userId an toàn
  String? get userId => _user?['_id']; // hoặc 'id' tùy backend

  /// GỌI SAU LOGIN
  void setUser(Map<String, dynamic> userData) {
    _user = userData;
    notifyListeners();
  }

  /// GỌI KHI LOGOUT
  void logout() {
    _user = null;
    notifyListeners();
  }
}