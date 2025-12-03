const Category = require('../../models/seller/category.model');
const { successResponse, errorResponse } = require('../../utils/response.util');

// Lấy tất cả categories
exports.getAllCategories = async (req, res) => {
  try {
    const { isActive } = req.query;
    
    const filter = {};
    if (isActive !== undefined) {
      filter.isActive = isActive === 'true';
    }

    const categories = await Category.find(filter)
      .sort({ createdAt: -1 })
      .select('_id name description icon isActive productsCount createdAt');

    return successResponse(res, 'Lấy danh sách danh mục thành công', {
      categories,
      total: categories.length
    });
  } catch (error) {
    console.error('Get categories error:', error);
    return errorResponse(res, 'Không thể lấy danh sách danh mục', 500);
  }
};

// Lấy chi tiết category
exports.getCategoryById = async (req, res) => {
  try {
    const { id } = req.params;

    const category = await Category.findById(id);

    if (!category) {
      return errorResponse(res, 'Không tìm thấy danh mục', 404);
    }

    return successResponse(res, 'Lấy thông tin danh mục thành công', category);
  } catch (error) {
    console.error('Get category error:', error);
    return errorResponse(res, 'Không thể lấy thông tin danh mục', 500);
  }
};

// Tạo category mới
exports.createCategory = async (req, res) => {
  try {
    const { name, description, isActive } = req.body; // Không lấy icon từ body, dùng req.file
    const userId = req.user.id;

    // Validate
    if (!name || name.trim() === '') {
      return errorResponse(res, 'Tên danh mục không được để trống', 400);
    }

    // Kiểm tra trùng tên
    const existingCategory = await Category.findOne({ 
      name: { $regex: new RegExp(`^${name.trim()}$`, 'i') } 
    });

    if (existingCategory) {
      return errorResponse(res, 'Tên danh mục đã tồn tại', 400);
    }

    // Xử lý icon từ upload (Cloudinary)
    const iconUrl = req.file ? req.file.path : null;
    if (!iconUrl && req.body.icon) {
      // Fallback nếu gửi icon URL qua body (tùy chọn, nhưng ưu tiên file upload)
      console.warn('Icon URL từ body được bỏ qua, ưu tiên file upload');
    }

    // Tạo category mới
    const newCategory = new Category({
      name: name.trim(),
      description: description?.trim() || '',
      icon: iconUrl,
      isActive: isActive !== undefined ? isActive : true,
      createdBy: userId
    });

    await newCategory.save();

    return successResponse(res, 'Thêm danh mục thành công', newCategory, 201);
  } catch (error) {
    console.error('Create category error:', error);
    return errorResponse(res, 'Không thể tạo danh mục', 500);
  }
};

// Cập nhật category
exports.updateCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, description, isActive } = req.body; // Không lấy icon từ body

    const category = await Category.findById(id);

    if (!category) {
      return errorResponse(res, 'Không tìm thấy danh mục', 404);
    }

    // Kiểm tra trùng tên (nếu đổi tên)
    if (name && name.trim() !== category.name) {
      const existingCategory = await Category.findOne({ 
        name: { $regex: new RegExp(`^${name.trim()}$`, 'i') },
        _id: { $ne: id }
      });

      if (existingCategory) {
        return errorResponse(res, 'Tên danh mục đã tồn tại', 400);
      }
    }

    // Update fields
    if (name) category.name = name.trim();
    if (description !== undefined) category.description = description?.trim() || '';
    if (isActive !== undefined) category.isActive = isActive;

    // Xử lý icon từ upload (Cloudinary) - ưu tiên file mới nếu có
    if (req.file) {
      // Optional: Xóa icon cũ trên Cloudinary nếu có
      // if (category.icon) { await cloudinary.uploader.destroy(publicIdFromUrl(category.icon)); }
      category.icon = req.file.path;
    } else if (req.body.icon !== undefined) {
      // Fallback: Cho phép update icon qua URL text (nếu không upload file)
      category.icon = req.body.icon;
    }

    await category.save();

    return successResponse(res, 'Cập nhật danh mục thành công', category);
  } catch (error) {
    console.error('Update category error:', error);
    return errorResponse(res, 'Không thể cập nhật danh mục', 500);
  }
};

// Xóa category
exports.deleteCategory = async (req, res) => {
  try {
    const { id } = req.params;

    const category = await Category.findById(id);

    if (!category) {
      return errorResponse(res, 'Không tìm thấy danh mục', 404);
    }

    // Kiểm tra xem có sản phẩm nào đang dùng category này không
    if (category.productsCount > 0) {
      return errorResponse(res, 'Không thể xóa danh mục đang có sản phẩm', 400);
    }

    // Optional: Xóa icon trên Cloudinary nếu có
    // if (category.icon) { await cloudinary.uploader.destroy(publicIdFromUrl(category.icon)); }

    await category.deleteOne();

    return successResponse(res, 'Xóa danh mục thành công');
  } catch (error) {
    console.error('Delete category error:', error);
    return errorResponse(res, 'Không thể xóa danh mục', 500);
  }
};