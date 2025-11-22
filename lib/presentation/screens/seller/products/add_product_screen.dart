import 'dart:io';

import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/presentation/widgets/seller/components/form_components.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';  // Thêm dependency: flutter pub add image_picker

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
  final TextEditingController _originalPriceController = TextEditingController();  // Thêm giá gốc
  final TextEditingController _discountController = TextEditingController();  // Thêm chiết khấu (%)
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  
  String? _selectedCategory;
  String? _selectedUnit;
  bool _isOrganic = false;
  bool _isLoading = false;
  
  List<File> _images = [];  // Thay _imageUrls bằng list File để hỗ trợ pick real images

  final List<Map<String, String>> _categories = [
    {'id': 'fruit', 'name': 'Trái cây'},
    {'id': 'vegetable', 'name': 'Rau xanh'},
    {'id': 'grain', 'name': 'Ngũ cốc'},
    {'id': 'herb', 'name': 'Rau gia vị'},
    {'id': 'mushroom', 'name': 'Nấm'},
  ];

  final List<String> _units = ['kg', 'gram', 'túi', 'bó', 'trái'];

  final ImagePicker _picker = ImagePicker();  // Khởi tạo ImagePicker

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _originalPriceController.dispose();  // Dispose mới
    _discountController.dispose();  // Dispose mới
    _stockController.dispose();
    _weightController.dispose();
    _skuController.dispose();
    super.dispose();
  }

  Future<void> _handleAddImage() async {
    try {
      final List<XFile>? pickedImages = await _picker.pickMultiImage(
        imageQuality: 80,  // Nén ảnh để tối ưu
        maxWidth: 800,
        maxHeight: 800,
        limit: 5 - _images.length,  // Giới hạn tổng 5 ảnh
      );
      if (pickedImages != null && pickedImages.isNotEmpty) {
        setState(() {
          _images.addAll(pickedImages.map((xfile) => File(xfile.path)));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi chọn ảnh: $e')),
      );
    }
  }

  void _handleRemoveImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      if (_images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng thêm ít nhất 1 ảnh sản phẩm'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      // Mock API call (thay bằng upload ảnh thật lên Firebase/Cloudinary)
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thêm sản phẩm thành công!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        Navigator.of(context).pop(true);
      }
    }
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
                    // Images Section (cập nhật để dùng File)
                    MultiImagePicker(
                      images: _images,  // Thay imageUrls bằng images (List<File>)
                      onAddImage: _handleAddImage,
                      onRemoveImage: _handleRemoveImage,
                    ),
                    
                    const SectionDivider(title: 'THÔNG TIN CỦA BẢN'),
                    
                    // Product Name
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
                    
                    // Category
                    CustomDropdownField<String>(
                      label: 'Danh mục',
                      value: _selectedCategory,
                      hint: 'Chọn danh mục',
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['id'],
                          child: Text(category['name']!),
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
                    const SizedBox(height: 16),
                    
                    // Description
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

                    // Organic checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _isOrganic,
                          onChanged: (value) {
                            setState(() => _isOrganic = value ?? false);
                          },
                          activeColor: AppTheme.primary,
                        ),
                        Text(
                          'Sản phẩm hữu cơ',
                          style: AppTheme.bodyMedium,
                        ),
                      ],
                    ),
                    
                    const SectionDivider(title: 'GIÁ & TỒN KHO'),
                    
                    // Price
                    CustomTextField(
                      label: 'Giá bán (giá khuyến mãi)',
                      hint: 'VD: 40000',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'VNĐ',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
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
                    
                    // Weight & Unit
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
                    
                    // Stock
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

                    // Section Khuyến mãi (mới)
                    const SectionDivider(title: 'KHUYẾN MÃI'),
                    const SizedBox(height: 16),
                    
                    // Original Price
                    CustomTextField(
                      label: 'Giá gốc (nếu có khuyến mãi)',
                      hint: 'VD: 50000',
                      controller: _originalPriceController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'VNĐ',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
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
                    
                    // Discount
                    CustomTextField(
                      label: 'Chiết khấu (%)',
                      hint: 'VD: 20',
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '%',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
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

// Cập nhật MultiImagePicker để hỗ trợ List<File> (thêm code này nếu widget chưa có)
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
            itemCount: images.length + 1,  // +1 cho nút add
            itemBuilder: (context, index) {
              if (index == images.length) {
                // Nút thêm ảnh
                return GestureDetector(
                  onTap: onAddImage,
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                  ),
                );
              }
              // Hiển thị ảnh
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        images[index],
                        fit: BoxFit.cover,
                        width: 100,
                        height: 120,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => onRemoveImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
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