

import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/presentation/widgets/seller/components/form_components.dart';
import 'package:flutter/material.dart';


class EditProductScreen extends StatefulWidget {
  final String productId;
  
  const EditProductScreen({
    super.key,
    required this.productId,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  
  String? _selectedCategory;
  String? _selectedUnit;
  bool _isOrganic = false;
  bool _isLoading = false;
  bool _isActive = true;
  
  List<String> _imageUrls = [];

  final List<Map<String, String>> _categories = [
    {'id': 'fruit', 'name': 'Trái cây'},
    {'id': 'vegetable', 'name': 'Rau xanh'},
    {'id': 'grain', 'name': 'Ngũ cốc'},
    {'id': 'herb', 'name': 'Rau gia vị'},
    {'id': 'mushroom', 'name': 'Nấm'},
  ];

  final List<String> _units = ['kg', 'gram', 'túi', 'bó', 'trái'];

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _weightController.dispose();
    _skuController.dispose();
    super.dispose();
  }

  Future<void> _loadProductData() async {
    // Mock load product data
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _nameController.text = 'Cà chua cherry';
      _descriptionController.text = 'Cà chua cherry tươi ngon, hữu cơ 100%';
      _priceController.text = '40000';
      _weightController.text = '1';
      _stockController.text = '50';
      _skuController.text = 'PRD-001';
      _selectedCategory = 'fruit';
      _selectedUnit = 'kg';
      _isOrganic = true;
      _isActive = true;
      _imageUrls = [
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150',
      ];
    });
  }

  void _handleAddImage() {
    setState(() {
      _imageUrls.add('https://via.placeholder.com/150');
    });
  }

  void _handleRemoveImage(int index) {
    setState(() {
      _imageUrls.removeAt(index);
    });
  }

  void _handleUpdate() async {
    if (_formKey.currentState!.validate()) {
      if (_imageUrls.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng thêm ít nhất 1 ảnh sản phẩm'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      // Mock API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật sản phẩm thành công!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        Navigator.of(context).pop(true);
      }
    }
  }

  void _handleDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa sản phẩm'),
        content: const Text('Bạn có chắc chắn muốn xóa sản phẩm này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() => _isLoading = true);
              
              // Mock API call
              await Future.delayed(const Duration(seconds: 1));
              
              if (mounted) {
                Navigator.of(context).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã xóa sản phẩm'),
                    backgroundColor: AppTheme.errorColor,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.errorColor),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chỉnh sửa sản phẩm', style: AppTheme.heading3),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppTheme.errorColor),
            onPressed: _handleDelete,
          ),
        ],
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
                    // Status Toggle
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _isActive 
                            ? AppTheme.successColor.withOpacity(0.1)
                            : AppTheme.errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _isActive ? AppTheme.successColor : AppTheme.errorColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isActive ? Icons.check_circle : Icons.cancel,
                            color: _isActive ? AppTheme.successColor : AppTheme.errorColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _isActive ? 'Đang hoạt động' : 'Ngừng bán',
                                  style: AppTheme.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: _isActive ? AppTheme.successColor : AppTheme.errorColor,
                                  ),
                                ),
                                Text(
                                  _isActive 
                                      ? 'Sản phẩm đang hiển thị trên shop'
                                      : 'Sản phẩm không hiển thị cho khách',
                                  style: AppTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _isActive,
                            onChanged: (value) {
                              setState(() => _isActive = value);
                            },
                            activeColor: AppTheme.successColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Images Section
                    MultiImagePicker(
                      imageUrls: _imageUrls,
                      onAddImage: _handleAddImage,
                      onRemoveImage: _handleRemoveImage,
                    ),
                    
                    const SectionDivider(title: 'THÔNG TIN CƠ BẢN'),
                    
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
                      label: 'Giá bán',
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
                      label: 'Mã SKU',
                      controller: _skuController,
                      enabled: false,
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Buttons
            ActionButtonGroup(
              primaryText: 'Cập nhật',
              onPrimary: _handleUpdate,
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