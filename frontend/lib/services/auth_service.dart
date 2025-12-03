import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  static const String baseUrl =
      'http://192.168.100.144:5000/api'; // Emulator Android, thay IP real cho device
  static final Uuid _uuid = Uuid();

// Lấy token từ SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Lấy role từ SharedPreferences
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  // Kiểm tra đã đăng nhập chưa
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
  static Future<Map<String, dynamic>> register(
    String username,
    String email,
    String phone,
    String password,
    String license,
    String role,
  ) async {
    final deviceId = _uuid.v4(); // Unique device
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
        'license': license,
        'role': role,
      }),
    );
    if (response.statusCode == 201) return json.decode(response.body);
    throw Exception(json.decode(response.body)['message'] ?? 'Registration failed');
  }

  static Future<Map<String, dynamic>> verifyOtp(
    String userId,
    String otp,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'otp': otp}),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('role', data['role']);
      return data;
    }
    throw Exception(json.decode(response.body)['message'] ?? 'OTP verification failed');
  }

  static Future<Map<String, dynamic>> login(
    String emailOrPhone,
    String password,
  ) async {
    final deviceId = _uuid.v4();
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': emailOrPhone,
        'password': password,
        'deviceId': deviceId,
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('role', data['user']['role']);
      return data;
    }
    throw Exception(json.decode(response.body)['message'] ?? 'Login failed');
  }
}
