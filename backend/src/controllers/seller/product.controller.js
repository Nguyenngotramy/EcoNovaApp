const Product = require('../../models/seller/product.model');
const Category = require('../../models/seller/category.model');
const { successResponse, errorResponse } = require('../../utils/response.util');

// Lấy tất cả sản phẩm của seller
exports.getSellerProducts = async (req, res) => {
  try {
    const sellerId = req.user.id;
    const { page = 1, limit = 20, category, status, search } = req.query;

    const filter = { seller: sellerId };

    if (category) filter.category = category;
    if (status) filter.status = status;
    if (search) {
      filter.$text = { $search: search };
    }

    const products = await Product.find(filter)
      .populate('category', 'name icon')
      .sort({ createdAt: -1 })
      .limit(limit * 1)
      .skip((page - 1) * limit);

    const total = await Product.countDocuments(filter);

    return successResponse(res, 'Lấy danh sách sản phẩm thành công', {
      products,
      pagination: {
        total,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    console.error('Get products error:', error);
    return errorResponse(res, 'Không thể lấy danh sách sản phẩm', 500);
  }
};

// Lấy chi tiết sản phẩm
exports.getProductById = async (req, res) => {
  try {
    const { id } = req.params;
    const sellerId = req.user.id;

    const product = await Product.findOne({ _id: id, seller: sellerId })
      .populate('category', 'name icon description');

    if (!product) {
      return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
    }

    return successResponse(res, 'Lấy thông tin sản phẩm thành công', product);
  } catch (error) {
    console.error('Get product error:', error);
    return errorResponse(res, 'Không thể lấy thông tin sản phẩm', 500);
  }
};

// Tạo sản phẩm mới
exports.createProduct = async (req, res) => {
  try {
    const {
      name,
      description,
      category,
      price,
      originalPrice,
      discount,
      stock,
      weight,
      unit,
      sku,
      isOrganic,
      images
    } = req.body;

    const sellerId = req.user.id;

    // Validate
    if (!name || !description || !category || !price || !stock || !weight || !unit || !images || images.length === 0) {
      return errorResponse(res, 'Vui lòng điền đầy đủ thông tin bắt buộc', 400);
    }

    // Kiểm tra category tồn tại
    const categoryExists = await Category.findById(category);
    if (!categoryExists) {
      return errorResponse(res, 'Danh mục không tồn tại', 404);
    }

    // Kiểm tra SKU trùng (nếu có)
    if (sku) {
      const existingSKU = await Product.findOne({ sku });
      if (existingSKU) {
        return errorResponse(res, 'Mã SKU đã tồn tại', 400);
      }
    }

    // Validate giá
    if (originalPrice && price >= originalPrice) {
      return errorResponse(res, 'Giá khuyến mãi phải nhỏ hơn giá gốc', 400);
    }

    // Tạo sản phẩm mới
    const newProduct = new Product({
      name: name.trim(),
      description: description.trim(),
      category,
      seller: sellerId,
      price,
      originalPrice: originalPrice || null,
      discount: discount || 0,
      stock,
      weight,
      unit,
      sku: sku || undefined,
      isOrganic: isOrganic || false,
      images
    });

    await newProduct.save();

    // Cập nhật productsCount trong category
    await Category.findByIdAndUpdate(category, { $inc: { productsCount: 1 } });

    // Populate category trước khi trả về
    await newProduct.populate('category', 'name icon');

    return successResponse(res, 'Thêm sản phẩm thành công', newProduct, 201);
  } catch (error) {
    console.error('Create product error:', error);
    return errorResponse(res, 'Không thể tạo sản phẩm', 500);
  }
};

// Cập nhật sản phẩm
exports.updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const sellerId = req.user.id;
    const updateData = req.body;

    const product = await Product.findOne({ _id: id, seller: sellerId });

    if (!product) {
      return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
    }

    // Validate giá nếu có update
    if (updateData.originalPrice && updateData.price >= updateData.originalPrice) {
      return errorResponse(res, 'Giá khuyến mãi phải nhỏ hơn giá gốc', 400);
    }

    // Kiểm tra SKU trùng nếu có thay đổi
    if (updateData.sku && updateData.sku !== product.sku) {
      const existingSKU = await Product.findOne({ 
        sku: updateData.sku,
        _id: { $ne: id }
      });
      if (existingSKU) {
        return errorResponse(res, 'Mã SKU đã tồn tại', 400);
      }
    }

    // Update category count nếu đổi category
    if (updateData.category && updateData.category !== product.category.toString()) {
      const categoryExists = await Category.findById(updateData.category);
      if (!categoryExists) {
        return errorResponse(res, 'Danh mục không tồn tại', 404);
      }

      // Giảm count category cũ, tăng count category mới
      await Category.findByIdAndUpdate(product.category, { $inc: { productsCount: -1 } });
      await Category.findByIdAndUpdate(updateData.category, { $inc: { productsCount: 1 } });
    }

    // Update các fields
    Object.keys(updateData).forEach(key => {
      if (updateData[key] !== undefined) {
        product[key] = updateData[key];
      }
    });

    await product.save();
    await product.populate('category', 'name icon');

    return successResponse(res, 'Cập nhật sản phẩm thành công', product);
  } catch (error) {
    console.error('Update product error:', error);
    return errorResponse(res, 'Không thể cập nhật sản phẩm', 500);
  }
};

// Xóa sản phẩm
exports.deleteProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const sellerId = req.user.id;

    const product = await Product.findOne({ _id: id, seller: sellerId });

    if (!product) {
      return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
    }

    // Giảm productsCount trong category
    await Category.findByIdAndUpdate(product.category, { $inc: { productsCount: -1 } });

    await product.deleteOne();

    return successResponse(res, 'Xóa sản phẩm thành công');
  } catch (error) {
    console.error('Delete product error:', error);
    return errorResponse(res, 'Không thể xóa sản phẩm', 500);
  }
};

// Cập nhật trạng thái sản phẩm
exports.updateProductStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    const sellerId = req.user.id;

    if (!['active', 'inactive'].includes(status)) {
      return errorResponse(res, 'Trạng thái không hợp lệ', 400);
    }

    const product = await Product.findOneAndUpdate(
      { _id: id, seller: sellerId },
      { status },
      { new: true }
    ).populate('category', 'name icon');

    if (!product) {
      return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
    }

    return successResponse(res, 'Cập nhật trạng thái thành công', product);
  } catch (error) {
    console.error('Update status error:', error);
    return errorResponse(res, 'Không thể cập nhật trạng thái', 500);
  }
};