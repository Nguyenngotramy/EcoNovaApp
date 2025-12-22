// lib/core/constants/api_constants.dart
import 'dart:io';

class ApiConstants {
  static String get baseUrl {
    // 1. Ưu tiên lấy từ environment variable khi chạy
    const String? fromEnv = String.fromEnvironment('API_URL');
    if (fromEnv != null && fromEnv.isNotEmpty) {
      return fromEnv.endsWith('/api') ? fromEnv : '$fromEnv/api';
    }

    // 2. Production URL (khi build release)
    if (bool.fromEnvironment('dart.vm.product')) {
      return 'https://api.nongsanviet.com/api';
    }

    // 3. Development URL - QUAN TRỌNG: khác nhau cho mỗi platform
    if (Platform.isAndroid) {
      // Android emulator: dùng 10.0.2.2 thay vì localhost
      return 'http://10.0.2.2:5000/api';
    } else if (Platform.isIOS) {
      // iOS simulator: có thể dùng localhost HOẶC IP máy thật
      // Nếu localhost không được thì dùng IP: 192.168.10.248
      return '192.168.20.7/api';
      // return 'http://192.168.10.248:5000/api'; // Nếu localhost lỗi
    } else {
      // Desktop hoặc web
      return '192.168.20.7/api';
    }
  }

  // Các endpoint
  static String get login => '$baseUrl/auth/login';
  static String get register => '$baseUrl/auth/register';
  static String get sellerProducts => '$baseUrl/seller/products';
  static String get sellerCategories => '$baseUrl/seller/categories';
  static String get customerProducts => '$baseUrl/products';

  // Method để lấy URL với path tùy chỉnh
  static String endpoint(String path) {
    return path.startsWith('/') ? '$baseUrl$path' : '$baseUrl/$path';
  }
}
