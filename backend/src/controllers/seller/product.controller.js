const Product = require('../../models/seller/product.model');
const Category = require('../../models/seller/category.model');
const { successResponse, errorResponse } = require('../../utils/response.util');

// Lấy tất cả sản phẩm của seller
exports.getSellerProducts = async (req, res) => {
  try {
    const sellerId = req.user._id || req.user.id; // Fix: support both _id and id
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
    const sellerId = req.user._id || req.user.id;
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
    console.log('📦 Create product request received');
    console.log('👤 User:', req.user);
    console.log('📄 Body:', JSON.stringify(req.body, null, 2));
    console.log('🖼️ Files:', req.files ? req.files.map(f => ({ filename: f.filename, path: f.path })) : 'No files');
    const {
      name,
      description,
      detailedDescription,
      category,
      originalPrice,
      salePrice,
      discount,
      stock,
      weight,
      unit,
      sku,
      isOrganic,
      isFeatured,
      badges,
      origin,
      storageInstructions,
      shelfLife,
      nutritionInfo
    } = req.body;
    const sellerId = req.user._id || req.user.id;
    // Validate required fields
    if (!name || name.trim() === '' || !description || description.trim() === '' || !category || !salePrice || !stock || !weight || !unit) {
      return errorResponse(res, 'Vui lòng điền đầy đủ thông tin bắt buộc (tên, mô tả, danh mục, giá bán, tồn kho, trọng lượng, đơn vị)', 400);
    }
    // Xử lý ảnh từ Cloudinary upload (req.files)
    const imageUrls = req.files ? req.files.map(file => file.path) : [];
    if (imageUrls.length === 0) {
      return errorResponse(res, 'Vui lòng thêm ít nhất 1 ảnh sản phẩm', 400);
    }
    // Kiểm tra category tồn tại
    const categoryExists = await Category.findById(category);
    if (!categoryExists) {
      return errorResponse(res, 'Danh mục không tồn tại', 404);
    }
    // Kiểm tra SKU trùng (nếu có)
    if (sku && sku.trim()) {
      const existingSKU = await Product.findOne({ sku: sku.trim() });
      if (existingSKU) {
        return errorResponse(res, 'Mã SKU đã tồn tại', 400);
      }
    }
    // Validate giá
    const parsedSalePrice = parseFloat(salePrice);
    const parsedOriginalPrice = originalPrice ? parseFloat(originalPrice) : null;
    if (isNaN(parsedSalePrice) || parsedSalePrice <= 0) {
      return errorResponse(res, 'Giá bán sản phẩm không hợp lệ (phải là số dương)', 400);
    }
    if (parsedOriginalPrice && parsedSalePrice < parsedOriginalPrice) {
      return errorResponse(res, 'Giá bán phải lớn hơn hoặc bằng giá gốc', 400);
    }
    // Parse nutritionInfo nếu có (từ JSON string)
    let parsedNutrition = {};
    if (nutritionInfo && nutritionInfo.trim()) {
      try {
        parsedNutrition = JSON.parse(nutritionInfo);
      } catch (err) {
        console.error('Invalid nutritionInfo JSON:', err);
        return errorResponse(res, 'Thông tin dinh dưỡng không hợp lệ (phải là JSON)', 400);
      }
    }
    // Parse badges nếu là string (từ join(','))
    const parsedBadges = Array.isArray(badges) ? badges : (badges ? badges.split(',').map(b => b.trim()).filter(b => b) : []);
    // Tạo sản phẩm mới với tất cả fields
    const newProduct = new Product({
      name: name.trim(),
      description: description.trim(),
      detailedDescription: detailedDescription ? detailedDescription.trim() : '',
      category,
      seller: sellerId,
      salePrice: parsedSalePrice,
      originalPrice: parsedOriginalPrice,
      discount: discount ? parseFloat(discount) : 0,
      stock: parseInt(stock),
      weight: parseFloat(weight),
      unit: unit.trim(),
      sku: sku ? sku.trim() : undefined,
      isOrganic: isOrganic === 'true' || isOrganic === true || isOrganic === '1',
      isFeatured: isFeatured === 'true' || isFeatured === true || isFeatured === '1',
      badges: parsedBadges,
      origin: origin ? origin.trim() : '',
      storageInstructions: storageInstructions ? storageInstructions.trim() : '',
      shelfLife: shelfLife ? parseInt(shelfLife) : null,
      nutritionInfo: parsedNutrition,
      images: imageUrls // Sử dụng URLs từ Cloudinary
    });
    await newProduct.save();
    console.log('✅ Product created:', newProduct._id);
    // Cập nhật productsCount trong category
    await Category.findByIdAndUpdate(category, { $inc: { productsCount: 1 } });
    // Populate category trước khi trả về
    await newProduct.populate('category', 'name icon');
    return successResponse(res, 'Thêm sản phẩm thành công', newProduct, 201);
  } catch (error) {
    console.error('❌ Create product error:', error);
    return errorResponse(res, `Không thể tạo sản phẩm: ${error.message}`, 500);
  }
};

// Cập nhật sản phẩm
exports.updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const sellerId = req.user._id || req.user.id;
    console.log('📦 Update product request received');
    console.log('📄 Body:', JSON.stringify(req.body, null, 2));
    console.log('🖼️ New files:', req.files ? req.files.map(f => ({ filename: f.filename, path: f.path })) : 'No new files');
    const product = await Product.findOne({ _id: id, seller: sellerId });
    if (!product) {
      return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
    }
    const updateData = req.body;
    // Validate giá nếu có update
    if (updateData.originalPrice && updateData.salePrice) {
      const parsedSalePrice = parseFloat(updateData.salePrice);
      const parsedOriginalPrice = parseFloat(updateData.originalPrice);
      if (parsedSalePrice < parsedOriginalPrice) {
        return errorResponse(res, 'Giá bán phải lớn hơn hoặc bằng giá gốc', 400);
      }
    }
    // Kiểm tra SKU trùng nếu có thay đổi
    if (updateData.sku && updateData.sku.trim() && updateData.sku.trim() !== product.sku) {
      const existingSKU = await Product.findOne({
        sku: updateData.sku.trim(),
        _id: { $ne: id }
      });
      if (existingSKU) {
        return errorResponse(res, 'Mã SKU đã tồn tại', 400);
      }
    }
    // Xử lý new images từ Cloudinary (append vào existing)
    const newImageUrls = req.files ? req.files.map(file => file.path) : [];
    if (newImageUrls.length > 0) {
      product.images = [...product.images, ...newImageUrls]; // Append (hoặc replace: product.images = newImageUrls nếu muốn thay thế)
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
      product.category = updateData.category;
    }
    // Parse nutritionInfo nếu có
    if (updateData.nutritionInfo) {
      try {
        product.nutritionInfo = JSON.parse(updateData.nutritionInfo);
      } catch (err) {
        return errorResponse(res, 'Thông tin dinh dưỡng không hợp lệ', 400);
      }
    }
    // Parse badges nếu là string
    if (updateData.badges !== undefined) {
      const parsedBadges = Array.isArray(updateData.badges) ? updateData.badges : (updateData.badges ? updateData.badges.split(',').map(b => b.trim()).filter(b => b) : []);
      product.badges = parsedBadges;
    }
    // Update các fields khác (chỉ nếu có giá trị mới)
    if (updateData.name) product.name = updateData.name.trim();
    if (updateData.description !== undefined) product.description = updateData.description ? updateData.description.trim() : '';
    if (updateData.detailedDescription !== undefined) product.detailedDescription = updateData.detailedDescription ? updateData.detailedDescription.trim() : '';
    if (updateData.salePrice !== undefined) product.salePrice = parseFloat(updateData.salePrice);
    if (updateData.originalPrice !== undefined) product.originalPrice = updateData.originalPrice ? parseFloat(updateData.originalPrice) : null;
    if (updateData.discount !== undefined) product.discount = updateData.discount ? parseFloat(updateData.discount) : 0;
    if (updateData.stock !== undefined) product.stock = parseInt(updateData.stock);
    if (updateData.weight !== undefined) product.weight = parseFloat(updateData.weight);
    if (updateData.unit) product.unit = updateData.unit.trim();
    if (updateData.sku !== undefined) product.sku = updateData.sku ? updateData.sku.trim() : undefined;
    if (updateData.origin !== undefined) product.origin = updateData.origin ? updateData.origin.trim() : '';
    if (updateData.storageInstructions !== undefined) product.storageInstructions = updateData.storageInstructions ? updateData.storageInstructions.trim() : '';
    if (updateData.shelfLife !== undefined) product.shelfLife = updateData.shelfLife ? parseInt(updateData.shelfLife) : null;
    if (updateData.isOrganic !== undefined) product.isOrganic = updateData.isOrganic === 'true' || updateData.isOrganic === true || updateData.isOrganic === '1';
    if (updateData.isFeatured !== undefined) product.isFeatured = updateData.isFeatured === 'true' || updateData.isFeatured === true || updateData.isFeatured === '1';
    await product.save();
    await product.populate('category', 'name icon');
    return successResponse(res, 'Cập nhật sản phẩm thành công', product);
  } catch (error) {
    console.error('Update product error:', error);
    return errorResponse(res, `Không thể cập nhật sản phẩm: ${error.message}`, 500);
  }
};

// Xóa sản phẩm
exports.deleteProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const sellerId = req.user._id || req.user.id;
    const product = await Product.findOne({ _id: id, seller: sellerId });
    if (!product) {
      return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
    }
    // Giảm productsCount trong category
    await Category.findByIdAndUpdate(product.category, { $inc: { productsCount: -1 } });
    // Optional: Xóa images trên Cloudinary (nếu cần, import cloudinary và destroy từng URL)
    // const cloudinary = require('cloudinary').v2;
    // if (product.images && product.images.length > 0) {
    // for (const imgUrl of product.images) {
    // const publicId = cloudinary.utils.extractPublicId(imgUrl);
    // await cloudinary.uploader.destroy(publicId);
    // }
    // }
    await product.deleteOne();
    return successResponse(res, 'Xóa sản phẩm thành công');
  } catch (error) {
    console.error('Delete product error:', error);
    return errorResponse(res, `Không thể xóa sản phẩm: ${error.message}`, 500);
  }
};

// Cập nhật trạng thái sản phẩm
exports.updateProductStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    const sellerId = req.user._id || req.user.id;
    if (!status || !['active', 'inactive'].includes(status)) {
      return errorResponse(res, 'Trạng thái không hợp lệ (phải là "active" hoặc "inactive")', 400);
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
    return errorResponse(res, `Không thể cập nhật trạng thái: ${error.message}`, 500);
  }
};