import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SemanticsService if needed for accessibility workaround
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http; // If needed for direct calls, but using services
import '../../../../core/theme/app_theme.dart';
import '../../../widgets/seller/components/form_components.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/product_service.dart'; // Import ProductService
import '../../../../services/category_service.dart'; // Import CategoryService mới

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers cơ bản
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailedDescController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController(); // Giá bán (selling price)
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  
  // Controllers mở rộng
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _storageController = TextEditingController();
  final TextEditingController _shelfLifeController = TextEditingController();
  
  // Nutrition info
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _fiberController = TextEditingController();
  final TextEditingController _vitaminsController = TextEditingController();
  
  String? _selectedCategory;
  String? _selectedUnit;
  bool _isOrganic = false;
  bool _isFeatured = false;
  bool _isLoading = false;
  bool _isLoadingCategories = false;
  
  List<File> _images = [];
  List<Map<String, dynamic>> _categories = [];
  List<String> _selectedBadges = [];

  final List<String> _units = ['kg', 'gram', 'túi', 'bó', 'trái', 'lon', 'chai', 'hộp'];
  final List<Map<String, dynamic>> _availableBadges = [
    {'value': 'bestseller', 'label': 'Bán chạy', 'color': Colors.orange},
    {'value': 'new', 'label': 'Mới', 'color': Colors.green},
    {'value': 'sale', 'label': 'Giảm giá', 'color': Colors.red},
    {'value': 'organic', 'label': 'Hữu cơ', 'color': Colors.teal},
    {'value': 'fresh', 'label': 'Tươi sống', 'color': Colors.blue},
    {'value': 'imported', 'label': 'Nhập khẩu', 'color': Colors.purple},
  ];
  
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
    _detailedDescController.dispose();
    _priceController.dispose();
    _salePriceController.dispose();
    _discountController.dispose();
    _stockController.dispose();
    _weightController.dispose();
    _skuController.dispose();
    _originController.dispose();
    _storageController.dispose();
    _shelfLifeController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _fiberController.dispose();
    _vitaminsController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoadingCategories = true);
    
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        _showSnackBar('Vui lòng đăng nhập lại', isError: true);
        return;
      }

      // Sử dụng CategoryService để lấy categories (chỉ gọi service ở 1 nơi)
      final categories = await CategoryService.getAllCategories(token: token);
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      _showSnackBar('Lỗi khi tải danh mục: $e', isError: true);
    } finally {
      setState(() => _isLoadingCategories = false);
    }
  }

  Future<void> _handleAddImage() async {
    try {
      final List<XFile>? pickedImages = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
        limit: 10 - _images.length, // Tối đa 10 ảnh
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
    setState(() => _images.removeAt(index));
  }

  // ===== DIALOG THÊM CATEGORY =====
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
                    
                    TextField(
                      controller: categoryNameController,
                      decoration: const InputDecoration(
                        labelText: 'Tên danh mục *',
                        hintText: 'VD: Trái cây tươi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
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

                      // Sử dụng CategoryService để tạo category (chỉ gọi service ở 1 nơi)
                      final result = await CategoryService.createCategory(
                        name: categoryNameController.text.trim(),
                        description: categoryDescController.text.trim().isNotEmpty ? categoryDescController.text.trim() : null,
                        iconFile: categoryIcon,
                        token: token,
                      );

                      if (result['success']) {
                        final newCategory = result['data'];
                        setState(() {
                          _categories.add(newCategory);
                          _selectedCategory = newCategory['_id'];
                        });

                        Navigator.pop(dialogContext);
                        _showSnackBar('Thêm danh mục thành công!');
                      } else {
                        _showSnackBar('Lỗi: ${result['message'] ?? 'Unknown error'}', isError: true);
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

  // ===== HÀM CLEAR FORM =====
  void _clearForm() {
    // Clear controllers
    _nameController.clear();
    _descriptionController.clear();
    _detailedDescController.clear();
    _priceController.clear();
    _salePriceController.clear();
    _discountController.clear();
    _stockController.clear();
    _weightController.clear();
    _skuController.clear();
    _originController.clear();
    _storageController.clear();
    _shelfLifeController.clear();
    _caloriesController.clear();
    _proteinController.clear();
    _carbsController.clear();
    _fatController.clear();
    _fiberController.clear();
    _vitaminsController.clear();

    // Reset states
    setState(() {
      _selectedCategory = null;
      _selectedUnit = null;
      _isOrganic = false;
      _isFeatured = false;
      _images.clear();
      _selectedBadges.clear();
    });

    // Reset form validation nếu cần
    _formKey.currentState?.reset();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_images.isEmpty) {
      _showSnackBar('Vui lòng thêm ít nhất 1 ảnh sản phẩm', isError: true);
      return;
    }

    if (_selectedCategory == null) {
      _showSnackBar('Vui lòng chọn danh mục', isError: true);
      return;
    }

    // ===== SỬA LẠI PHẦN VALIDATION GIÁ BÁN =====
    if (_salePriceController.text.isNotEmpty) {
      final originalPrice = double.tryParse(_priceController.text);
      final salePrice = double.tryParse(_salePriceController.text);
      if (originalPrice != null && salePrice != null && salePrice < originalPrice) {
        _showSnackBar('Giá bán phải lớn hơn hoặc bằng giá gốc', isError: true);
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      final token = await AuthService.getToken();
      if (token == null) {
        _showSnackBar('Vui lòng đăng nhập lại', isError: true);
        return;
      }

      // Xây dựng productData map
      final productData = <String, dynamic>{
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'detailedDescription': _detailedDescController.text.trim(),
        'category': _selectedCategory!,
        'salePrice': double.parse(_salePriceController.text),
        'originalPrice': _priceController.text.isNotEmpty 
            ? double.parse(_priceController.text) 
            : null,
        'discount': _discountController.text.isNotEmpty 
            ? double.parse(_discountController.text) 
            : 0,
        'stock': int.parse(_stockController.text),
        'weight': double.parse(_weightController.text),
        'unit': _selectedUnit ?? 'kg',
        'sku': _skuController.text.isNotEmpty ? _skuController.text : null,
        'origin': _originController.text.trim(),
        'storageInstructions': _storageController.text.trim(),
        'shelfLife': _shelfLifeController.text.isNotEmpty 
            ? int.parse(_shelfLifeController.text) 
            : null,
        'isOrganic': _isOrganic,
        'isFeatured': _isFeatured,
        'badges': _selectedBadges,
      };

      // Nutrition info
      final nutritionInfo = {
        'calories': _caloriesController.text.trim(),
        'protein': _proteinController.text.trim(),
        'carbs': _carbsController.text.trim(),
        'fat': _fatController.text.trim(),
        'fiber': _fiberController.text.trim(),
        'vitamins': _vitaminsController.text.trim(),
      };
      productData['nutritionInfo'] = nutritionInfo;
      // Sử dụng ProductService để tạo product (chỉ gọi service ở 1 nơi)
      final result = await ProductService.createProduct(
        productData: productData,
        imageFiles: _images, // Danh sách ảnh
        token: token,
      );

      if (result['success']) {
        _clearForm();
        _showSnackBar('Thêm sản phẩm thành công!');
      } else {
        _showSnackBar('Lỗi: ${result['message'] ?? 'Unknown error'}', isError: true);
      }
    } catch (e) {
      print('Save exception: $e');
      _showSnackBar('Có lỗi xảy ra: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
  if (!mounted) return; // Thêm check này
  
  // Wrap trong try-catch để tránh lỗi accessibility
  try {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppTheme.errorColor : AppTheme.successColor,
        behavior: SnackBarBehavior.floating, // Thêm dòng này
        duration: const Duration(seconds: 3),
      ),
    );
  } catch (e) {
    // Fallback: print to console if SnackBar fails
    debugPrint('SnackBar error: $message');
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
                    // ===== HÌNH ẢNH =====
                    MultiImagePicker(
                      images: _images,
                      onAddImage: _handleAddImage,
                      onRemoveImage: _handleRemoveImage,
                    ),
                    
                    const SectionDivider(title: 'THÔNG TIN CƠ BẢN'),
                    
                    CustomTextField(
                      label: 'Tên sản phẩm',
                      hint: 'VD: Cà chua cherry',
                      controller: _nameController,
                      validator: (value) => value?.isEmpty ?? true ? 'Vui lòng nhập tên' : null,
                    ),
                    const SizedBox(height: 16),
                    
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
                                  onChanged: (value) => setState(() => _selectedCategory = value),
                                  validator: (value) => value == null ? 'Chọn danh mục' : null,
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
                    
                    CustomTextField(
                      label: 'Mô tả ngắn',
                      hint: 'Mô tả ngắn gọn về sản phẩm',
                      controller: _descriptionController,
                      maxLines: 3,
                      validator: (value) => value?.isEmpty ?? true ? 'Vui lòng nhập mô tả' : null,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Mô tả chi tiết',
                      hint: 'Mô tả đầy đủ về sản phẩm, lợi ích, cách sử dụng...',
                      controller: _detailedDescController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),

                    // Badges
                    const Text('Nhãn sản phẩm', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableBadges.map((badge) {
                        final isSelected = _selectedBadges.contains(badge['value']);
                        return FilterChip(
                          label: Text(badge['label']),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedBadges.add(badge['value']);
                              } else {
                                _selectedBadges.remove(badge['value']);
                              }
                            });
                          },
                          selectedColor: badge['color'].withOpacity(0.3),
                          checkmarkColor: badge['color'],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Checkbox(
                          value: _isOrganic,
                          onChanged: (value) => setState(() => _isOrganic = value ?? false),
                          activeColor: AppTheme.primary,
                        ),
                        const Text('Sản phẩm hữu cơ'),
                        const SizedBox(width: 16),
                        Checkbox(
                          value: _isFeatured,
                          onChanged: (value) => setState(() => _isFeatured = value ?? false),
                          activeColor: AppTheme.primary,
                        ),
                        const Text('Sản phẩm nổi bật'),
                      ],
                    ),
                    
                    const SectionDivider(title: 'GIÁ & TỒN KHO'),
                    
                    CustomTextField(
                      label: 'Giá gốc',
                      hint: '40000',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('VNĐ'),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Nhập giá';
                        if (double.tryParse(value!) == null) return 'Giá không hợp lệ';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            label: 'Khối lượng',
                            hint: '1',
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            validator: (value) => value?.isEmpty ?? true ? 'Nhập khối lượng' : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomDropdownField<String>(
                            label: 'Đơn vị',
                            value: _selectedUnit,
                            hint: 'Chọn',
                            items: _units.map((unit) => DropdownMenuItem(value: unit, child: Text(unit))).toList(),
                            onChanged: (value) => setState(() => _selectedUnit = value),
                            validator: (value) => value == null ? 'Chọn' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Tồn kho',
                      hint: '50',
                      controller: _stockController,
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty ?? true ? 'Nhập tồn kho' : null,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Mã SKU (Tùy chọn)',
                      hint: 'PRD-001',
                      controller: _skuController,
                    ),

                    const SectionDivider(title: 'KHUYẾN MÃI'),
                    
                    CustomTextField(
                      label: 'Giá bán',
                      hint: '50000',
                      controller: _salePriceController,
                      keyboardType: TextInputType.number,
                      suffixIcon: const Padding(padding: EdgeInsets.all(16), child: Text('VNĐ')),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          final originalPrice = double.tryParse(_priceController.text);
                          final salePrice = double.tryParse(value);
                          // ===== SỬA LẠI ĐIỀU KIỆN VALIDATION =====
                          if (originalPrice != null && salePrice != null && salePrice < originalPrice) {
                            return 'Giá bán phải lớn hơn hoặc bằng giá gốc';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Chiết khấu (%)',
                      hint: '20',
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      suffixIcon: const Padding(padding: EdgeInsets.all(16), child: Text('%')),
                    ),

                    const SectionDivider(title: 'THÔNG TIN BỔ SUNG'),
                    
                    CustomTextField(
                      label: 'Xuất xứ',
                      hint: 'VD: Đà Lạt, Việt Nam',
                      controller: _originController,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Hướng dẫn bảo quản',
                      hint: 'VD: Bảo quản nơi khô ráo, thoáng mát',
                      controller: _storageController,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Hạn sử dụng (số ngày)',
                      hint: 'VD: 7',
                      controller: _shelfLifeController,
                      keyboardType: TextInputType.number,
                    ),

                    const SectionDivider(title: 'THÔNG TIN DINH DƯỠNG'),
                    
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Calories',
                            hint: '50 kcal',
                            controller: _caloriesController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            label: 'Protein',
                            hint: '2g',
                            controller: _proteinController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Carbs',
                            hint: '10g',
                            controller: _carbsController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            label: 'Fat',
                            hint: '0.5g',
                            controller: _fatController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Chất xơ',
                      hint: '3g',
                      controller: _fiberController,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      label: 'Vitamin & Khoáng chất',
                      hint: 'VD: Vitamin C, Kali, Folate',
                      controller: _vitaminsController,
                      maxLines: 2,
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            
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

// Phần MultiImagePicker giữ nguyên
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
        const Text('Ảnh sản phẩm (tối đa 10)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length + 1,
            itemBuilder: (context, index) {
              if (index == images.length) {
                return GestureDetector(
                  onTap: images.length < 10 ? onAddImage : null, // Tối đa 10
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: images.length < 10 ? Colors.grey[200] : Colors.grey[300],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.add_a_photo, 
                      size: 40, 
                      color: images.length < 10 ? Colors.grey : Colors.grey[400]
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