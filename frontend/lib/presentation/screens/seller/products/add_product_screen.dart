import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../widgets/seller/components/form_components.dart';
import '../../../../services/auth_service.dart'; // Import AuthService

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  
  String? _selectedCategory;
  String? _selectedUnit;
  bool _isOrganic = false;
  bool _isLoading = false;
  bool _isLoadingCategories = false;
  
  List<File> _images = [];
  List<Map<String, dynamic>> _categories = [];

  final List<String> _units = ['kg', 'gram', 'túi', 'bó', 'trái'];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _originalPriceController.dispose();
    _discountController.dispose();
    _stockController.dispose();
    _weightController.dispose();
    _skuController.dispose();
    super.dispose();
  }

  // ===== LOAD CATEGORIES TỪ API =====
  Future<void> _loadCategories() async {
    setState(() => _isLoadingCategories = true);
    
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        _showSnackBar('Vui lòng đăng nhập lại', isError: true);
        return;
      }

      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/seller/categories?isActive=true'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _categories = List<Map<String, dynamic>>.from(data['data']['categories']);
        });
      } else {
        final error = json.decode(response.body);
        _showSnackBar('Lỗi: ${error['message']}', isError: true);
      }
    } catch (e) {
      _showSnackBar('Lỗi khi tải danh mục: $e', isError: true);
    } finally {
      setState(() => _isLoadingCategories = false);
    }
  }

  // ===== MỞ DIALOG THÊM CATEGORY =====
  Future<void> _showAddCategoryDialog() async {
    final TextEditingController categoryNameController = TextEditingController();
    final TextEditingController categoryDescController = TextEditingController();
    File? categoryIcon;
    bool isSaving = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Thêm danh mục mới'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon picker
                    GestureDetector(
                      onTap: () async {
                        final XFile? pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                          maxWidth: 512,
                          maxHeight: 512,
                        );
                        if (pickedFile != null) {
                          setDialogState(() {
                            categoryIcon = File(pickedFile.path);
                          });
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: categoryIcon != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(categoryIcon!, fit: BoxFit.cover),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate, size: 32, color: Colors.grey[600]),
                                  const SizedBox(height: 4),
                                  Text('Icon', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Tên danh mục
                    TextField(
                      controller: categoryNameController,
                      decoration: const InputDecoration(
                        labelText: 'Tên danh mục *',
                        hintText: 'VD: Trái cây tươi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Mô tả
                    TextField(
                      controller: categoryDescController,
                      decoration: const InputDecoration(
                        labelText: 'Mô tả',
                        hintText: 'Mô tả ngắn về danh mục',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSaving ? null : () => Navigator.pop(dialogContext),
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  onPressed: isSaving ? null : () async {
                    if (categoryNameController.text.trim().isEmpty) {
                      _showSnackBar('Vui lòng nhập tên danh mục', isError: true);
                      return;
                    }

                    setDialogState(() => isSaving = true);

                    try {
                      final token = await AuthService.getToken();
                      if (token == null) {
                        _showSnackBar('Vui lòng đăng nhập lại', isError: true);
                        return;
                      }

                      // Upload icon nếu có
                      String? iconUrl;
                      if (categoryIcon != null) {
                        iconUrl = await _uploadImage(categoryIcon!);
                      }

                      // Gọi API tạo category
                      final response = await http.post(
                        Uri.parse('${ApiConstants.baseUrl}/seller/categories'),
                        headers: {
                          'Content-Type': 'application/json',
                          'Authorization': 'Bearer $token',
                        },
                        body: json.encode({
                          'name': categoryNameController.text.trim(),
                          'description': categoryDescController.text.trim(),
                          'icon': iconUrl,
                          'isActive': true,
                        }),
                      );

                      if (response.statusCode == 201) {
                        final newCategory = json.decode(response.body)['data'];
                        
                        // Thêm vào list và chọn luôn
                        setState(() {
                          _categories.add(newCategory);
                          _selectedCategory = newCategory['_id'];
                        });

                        Navigator.pop(dialogContext);
                        _showSnackBar('Thêm danh mục thành công!');
                      } else {
                        final error = json.decode(response.body);
                        _showSnackBar('Lỗi: ${error['message']}', isError: true);
                      }
                    } catch (e) {
                      _showSnackBar('Có lỗi xảy ra: $e', isError: true);
                    } finally {
                      setDialogState(() => isSaving = false);
                    }
                  },
                  child: isSaving 
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Thêm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ===== UPLOAD ẢNH =====
  Future<String?> _uploadImage(File imageFile) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        _showSnackBar('Vui lòng đăng nhập lại', isError: true);
        return null;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.baseUrl}/upload/image'),
      );
      
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      request.headers['Authorization'] = 'Bearer $token';
      
      var response = await request.send();
      
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var data = json.decode(responseData);
        return data['url'];
      }
      return null;
    } catch (e) {
      print('Upload image failed: $e');
      return null;
    }
  }

  Future<void> _handleAddImage() async {
    try {
      final List<XFile>? pickedImages = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
        limit: 5 - _images.length,
      );
      if (pickedImages != null && pickedImages.isNotEmpty) {
        setState(() {
          _images.addAll(pickedImages.map((xfile) => File(xfile.path)));
        });
      }
    } catch (e) {
      _showSnackBar('Lỗi khi chọn ảnh: $e', isError: true);
    }
  }

  void _handleRemoveImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  // ===== LƯU SẢN PHẨM =====
  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_images.isEmpty) {
      _showSnackBar('Vui lòng thêm ít nhất 1 ảnh sản phẩm', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final token = await AuthService.getToken();
      if (token == null) {
        _showSnackBar('Vui lòng đăng nhập lại', isError: true);
        return;
      }

      // 1. Upload tất cả ảnh
      List<String> uploadedUrls = [];
      for (var image in _images) {
        final url = await _uploadImage(image);
        if (url != null) uploadedUrls.add(url);
      }

      if (uploadedUrls.isEmpty) {
        _showSnackBar('Không thể upload ảnh', isError: true);
        return;
      }

      // 2. Tạo product payload
      final productData = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'category': _selectedCategory,
        'price': double.parse(_priceController.text),
        'originalPrice': _originalPriceController.text.isNotEmpty 
            ? double.parse(_originalPriceController.text) 
            : null,
        'discount': _discountController.text.isNotEmpty 
            ? double.parse(_discountController.text) 
            : null,
        'stock': int.parse(_stockController.text),
        'weight': double.parse(_weightController.text),
        'unit': _selectedUnit,
        'sku': _skuController.text.isNotEmpty ? _skuController.text : null,
        'isOrganic': _isOrganic,
        'images': uploadedUrls,
      };

      // 3. Gửi lên backend
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/seller/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(productData),
      );

      if (response.statusCode == 201) {
        _showSnackBar('Thêm sản phẩm thành công!');
        if (mounted) Navigator.of(context).pop(true);
      } else {
        final error = json.decode(response.body);
        _showSnackBar('Lỗi: ${error['message']}', isError: true);
      }
    } catch (e) {
      _showSnackBar('Có lỗi xảy ra: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppTheme.errorColor : AppTheme.successColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Thêm sản phẩm mới', style: AppTheme.heading3),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== HÌNH ẢNH =====
                    MultiImagePicker(
                      images: _images,
                      onAddImage: _handleAddImage,
                      onRemoveImage: _handleRemoveImage,
                    ),
                    
                    const SectionDivider(title: 'THÔNG TIN CƠ BẢN'),
                    
                    // Tên sản phẩm
                    CustomTextField(
                      label: 'Tên sản phẩm',
                      hint: 'VD: Cà chua cherry',
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tên sản phẩm';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // ===== DANH MỤC (CÓ NÚT THÊM) =====
                    Row(
                      children: [
                        Expanded(
                          child: _isLoadingCategories
                              ? const Center(child: CircularProgressIndicator())
                              : CustomDropdownField<String>(
                                  label: 'Danh mục',
                                  value: _selectedCategory,
                                  hint: 'Chọn danh mục',
                                  items: _categories.map((category) {
                                    return DropdownMenuItem<String>(
                                      value: category['_id'],
                                      child: Text(category['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() => _selectedCategory = value);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng chọn danh mục';
                                    }
                                    return null;
                                  },
                                ),
                        ),
                        const SizedBox(width: 8),
                        // Nút thêm danh mục
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: IconButton(
                            onPressed: _showAddCategoryDialog,
                            icon: const Icon(Icons.add_circle, color: AppTheme.primary),
                            iconSize: 32,
                            tooltip: 'Thêm danh mục mới',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Mô tả
                    CustomTextField(
                      label: 'Mô tả sản phẩm',
                      hint: 'Nhập mô tả chi tiết về sản phẩm',
                      controller: _descriptionController,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mô tả sản phẩm';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Checkbox Organic
                    Row(
                      children: [
                        Checkbox(
                          value: _isOrganic,
                          onChanged: (value) {
                            setState(() => _isOrganic = value ?? false);
                          },
                          activeColor: AppTheme.primary,
                        ),
                        Text('Sản phẩm hữu cơ', style: AppTheme.bodyMedium),
                      ],
                    ),
                    
                    const SectionDivider(title: 'GIÁ & TỒN KHO'),
                    
                    // Giá bán
                    CustomTextField(
                      label: 'Giá bán',
                      hint: 'VD: 40000',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('VNĐ', style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập giá';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Giá không hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Khối lượng & Đơn vị
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            label: 'Khối lượng/Số lượng',
                            hint: 'VD: 1',
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nhập khối lượng';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: CustomDropdownField<String>(
                            label: 'Đơn vị',
                            value: _selectedUnit,
                            hint: 'Chọn',
                            items: _units.map((unit) {
                              return DropdownMenuItem<String>(
                                value: unit,
                                child: Text(unit),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _selectedUnit = value);
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Chọn đơn vị';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Tồn kho
                    CustomTextField(
                      label: 'Số lượng tồn kho',
                      hint: 'VD: 50',
                      controller: _stockController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số lượng tồn kho';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Số lượng không hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // SKU
                    CustomTextField(
                      label: 'Mã SKU (Tùy chọn)',
                      hint: 'VD: PRD-001',
                      controller: _skuController,
                    ),

                    const SectionDivider(title: 'KHUYẾN MÃI'),
                    
                    // Giá gốc
                    CustomTextField(
                      label: 'Giá gốc (nếu có khuyến mãi)',
                      hint: 'VD: 50000',
                      controller: _originalPriceController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('VNĐ', style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary)),
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (double.tryParse(value) == null) {
                            return 'Giá gốc không hợp lệ';
                          }
                          final salePrice = double.tryParse(_priceController.text);
                          final origPrice = double.tryParse(value);
                          if (salePrice != null && origPrice != null && salePrice >= origPrice) {
                            return 'Giá khuyến mãi phải nhỏ hơn giá gốc';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Chiết khấu
                    CustomTextField(
                      label: 'Chiết khấu (%)',
                      hint: 'VD: 20',
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('%', style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary)),
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (double.tryParse(value) == null) {
                            return 'Chiết khấu không hợp lệ';
                          }
                          final discount = double.tryParse(value);
                          if (discount != null && (discount <= 0 || discount > 100)) {
                            return 'Chiết khấu phải từ 1-100%';
                          }
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Buttons
            ActionButtonGroup(
              primaryText: 'Thêm sản phẩm',
              onPrimary: _handleSave,
              secondaryText: 'Hủy',
              onSecondary: () => Navigator.of(context).pop(),
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}

// ===== MULTI IMAGE PICKER WIDGET =====
class MultiImagePicker extends StatelessWidget {
  final List<File> images;
  final VoidCallback onAddImage;
  final Function(int) onRemoveImage;

  const MultiImagePicker({
    super.key,
    required this.images,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ảnh sản phẩm (tối đa 5)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length + 1,
            itemBuilder: (context, index) {
              if (index == images.length) {
                return GestureDetector(
                  onTap: images.length < 5 ? onAddImage : null,
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: images.length < 5 ? Colors.grey[200] : Colors.grey[300],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.add_a_photo, 
                      size: 40, 
                      color: images.length < 5 ? Colors.grey : Colors.grey[400]
                    ),
                  ),
                );
              }
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(images[index], fit: BoxFit.cover, width: 100, height: 120),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => onRemoveImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: const Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}