import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class ProductService {
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

  // Lấy chi tiết sản phẩm
  static Future<Map<String, dynamic>> getProductDetail(String productId) async {
    try {
      final uri = _buildUri('/api/products/$productId');
      
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']; // Trả về product object
      } else {
        throw Exception(json.decode(response.body)['message'] ?? 'Failed to load product');
      }
    } catch (e) {
      print('Get product detail error: $e');
      throw Exception('Không thể tải thông tin sản phẩm');
    }
  }

  // Lấy danh sách sản phẩm
  static Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    double? minPrice,
    double? maxPrice,
    bool? isOrganic,
    String? badges,
    String sort = '-createdAt',
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
        'sort': sort,
      };

      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;
      if (minPrice != null) queryParams['minPrice'] = minPrice.toString();
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice.toString();
      if (isOrganic != null) queryParams['isOrganic'] = isOrganic.toString();
      if (badges != null) queryParams['badges'] = badges;

      final uri = _buildUri('/api/products', queryParams);
      
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Get products error: $e');
      throw Exception('Không thể tải danh sách sản phẩm');
    }
  }

  // Lấy sản phẩm theo category
  static Future<List<dynamic>> getProductsByCategory(String categoryId, {int page = 1, int limit = 20}) async {
    try {
      final uri = _buildUri('/api/products/category/$categoryId', {
        'page': page.toString(),
        'limit': limit.toString(),
      });
      
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return data['products'];
      } else {
        throw Exception('Failed to load products by category');
      }
    } catch (e) {
      print('Get products by category error: $e');
      throw Exception('Không thể tải sản phẩm');
    }
  }

  // Lấy sản phẩm nổi bật
 static Future<List<dynamic>> getFeaturedProducts() async {
  try {
    final uri = _buildUri('/api/products/featured');

    // Không thêm Authorization header
    final headers = {'Content-Type': 'application/json'};

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return data['products'];
    } else {
      throw Exception('Failed to load featured products');
    }
  } catch (e) {
    print('Get featured products error: $e');
    throw Exception('Không thể tải sản phẩm nổi bật');
  }
}


  // Lấy sản phẩm liên quan
  static Future<List<dynamic>> getRelatedProducts(String productId) async {
    try {
      final uri = _buildUri('/api/products/related/$productId');
      
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return data['relatedProducts'];
      } else {
        throw Exception('Failed to load related products');
      }
    } catch (e) {
      print('Get related products error: $e');
      throw Exception('Không thể tải sản phẩm liên quan');
    }
  }
  // Tạo sản phẩm mới (với upload ảnh tùy chọn)
  static Future<Map<String, dynamic>> createProduct({
    required Map<String, dynamic> productData,
    List<File>? imageFiles, // Danh sách file ảnh (nếu có)
    required String token,
  }) async {
    try {
      final uri = _buildUri('/api/seller/products'); // Giả sử route cho seller create product

      // Tạo multipart request
      var request = http.MultipartRequest('POST', uri);
      
      // Add auth header
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields từ productData
      productData.forEach((key, value) {
        if (value is String || value is int || value is double || value is bool) {
          request.fields[key] = value.toString();
        }
      });

      // Add file(s) nếu có (giả sử backend hỗ trợ multiple images với field 'images[]')
      if (imageFiles != null && imageFiles.isNotEmpty) {
        for (int i = 0; i < imageFiles.length; i++) {
          final file = imageFiles[i];
          final multipartFile = await http.MultipartFile.fromPath(
            'images', // Field name phải khớp với backend (e.g., productUpload.array('images'))
            file.path,
            contentType: MediaType('image', 'jpeg'), // Điều chỉnh theo loại file nếu cần
          );
          request.files.add(multipartFile);
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(errorBody['message'] ?? 'Failed to create product');
      }
    } catch (e) {
      print('Create product error: $e');
      throw Exception('Không thể tạo sản phẩm');
    }
  }

  // Cập nhật sản phẩm (với upload ảnh tùy chọn)
  static Future<Map<String, dynamic>> updateProduct({
    required String productId,
    required Map<String, dynamic> productData,
    List<File>? imageFiles, // Danh sách file ảnh mới (nếu có, backend sẽ xử lý append/replace)
    required String token,
  }) async {
    try {
      final uri = _buildUri('/api/seller/products/$productId');

      // Tạo multipart request cho PUT (http hỗ trợ)
      var request = http.MultipartRequest('PUT', uri);
      
      // Add auth header
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields từ productData
      productData.forEach((key, value) {
        if (value is String || value is int || value is double || value is bool) {
          request.fields[key] = value.toString();
        }
      });

      // Add file(s) nếu có
      if (imageFiles != null && imageFiles.isNotEmpty) {
        for (int i = 0; i < imageFiles.length; i++) {
          final file = imageFiles[i];
          final multipartFile = await http.MultipartFile.fromPath(
            'images',
            file.path,
            contentType: MediaType('image', 'jpeg'),
          );
          request.files.add(multipartFile);
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(errorBody['message'] ?? 'Failed to update product');
      }
    } catch (e) {
      print('Update product error: $e');
      throw Exception('Không thể cập nhật sản phẩm');
    }
  }

  // Xóa sản phẩm
  static Future<Map<String, dynamic>> deleteProduct(String productId, {required String token}) async {
    try {
      final uri = _buildUri('/api/seller/products/$productId');
      
      final response = await http.delete(
        uri,
        headers: _getHeaders(token: token),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return {'success': true, 'message': 'Product deleted successfully'};
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(errorBody['message'] ?? 'Failed to delete product');
      }
    } catch (e) {
      print('Delete product error: $e');
      throw Exception('Không thể xóa sản phẩm');
    }
  }
}