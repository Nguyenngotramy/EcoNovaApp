import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  Map<String, dynamic>? _user; // Dữ liệu user, null khi chưa login

  Map<String, dynamic>? get user => _user;

  void setUser(Map<String, dynamic> userData) {
    _user = userData;
    notifyListeners(); // thông báo cho tất cả widget lắng nghe
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
