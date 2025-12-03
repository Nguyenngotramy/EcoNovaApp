import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CategoryService {
  static const String _host = '192.168.100.144';
  static const int _port = 5000;

  static Uri _buildUri(String path, [Map<String, dynamic>? queryParams]) {
    return Uri(
      scheme: 'http',
      host: _host,
      port: _port,
      path: path,
      queryParameters: queryParams,
    );
  }

  // Helper method to add auth header if token is provided
  static Map<String, String> _getHeaders({String? token}) {
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Lấy danh sách categories
  static Future<List<Map<String, dynamic>>> getAllCategories({String? token}) async {
    try {
      final uri = _buildUri('/api/seller/categories');
      
      final response = await http.get(
        uri,
        headers: _getHeaders(token: token),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return List<Map<String, dynamic>>.from(data['data']['categories']);
        }
        return [];
      } else {
        throw Exception(json.decode(response.body)['message'] ?? 'Failed to load categories');
      }
    } catch (e) {
      print('Get categories error: $e');
      throw Exception('Không thể tải danh sách danh mục');
    }
  }

  // Tạo category mới (với upload icon tùy chọn)
  static Future<Map<String, dynamic>> createCategory({
    required String name,
    String? description,
    File? iconFile, // File icon tùy chọn
    required String token,
  }) async {
    try {
      final uri = _buildUri('/api/seller/categories');

      // Tạo multipart request
      var request = http.MultipartRequest('POST', uri);
      
      // Add auth header
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields['name'] = name;
      request.fields['description'] = description ?? '';
      request.fields['isActive'] = 'true';

      // Add icon file nếu có
      if (iconFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'icon', // Field name khớp backend middleware
            iconFile.path,
            contentType: MediaType('image', 'jpeg'), // Điều chỉnh theo loại file nếu cần
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return {'success': true, 'data': data['data']};
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(errorBody['message'] ?? 'Failed to create category');
      }
    } catch (e) {
      print('Create category error: $e');
      throw Exception('Không thể tạo danh mục');
    }
  }
}