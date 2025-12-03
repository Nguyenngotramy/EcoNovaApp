// controllers/buyer/product.controller.js
const Product = require('../../models/seller/product.model');
const { successResponse, errorResponse } = require('../../utils/response.util');

// Lấy danh sách sản phẩm (có filter, search, pagination)
const getProducts = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 20,
      category,
      search,
      minPrice,
      maxPrice,
      isOrganic,
      badges,
      sort = '-createdAt' // Mặc định sắp xếp theo mới nhất
    } = req.query;

    const filter = { status: 'active' }; // Chỉ lấy sản phẩm active

    if (category) filter.category = category;
    if (search) filter.$text = { $search: search };
    if (isOrganic) filter.isOrganic = isOrganic === 'true';
    if (badges) filter.badges = { $in: badges.split(',') };

    // Filter theo giá
    if (minPrice || maxPrice) {
      filter.price = {};
      if (minPrice) filter.price.$gte = parseFloat(minPrice);
      if (maxPrice) filter.price.$lte = parseFloat(maxPrice);
    }

    const products = await Product.find(filter)
      .populate('category', 'name icon')
      .populate('seller', 'username email') // Thông tin seller
      .sort(sort)
      .limit(parseInt(limit))
      .skip((page - 1) * parseInt(limit));

    const total = await Product.countDocuments(filter);

    return successResponse(res, 'Lấy danh sách sản phẩm thành công', {
      products,
      pagination: {
        total,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(total / parseInt(limit))
      }
    });
  } catch (error) {
    console.error('Get products error:', error);
    return errorResponse(res, 'Không thể lấy danh sách sản phẩm', 500);
  }
};

// Lấy chi tiết 1 sản phẩm
const getProductById = async (req, res) => {
  try {
    const { id } = req.params;

    const product = await Product.findOne({ _id: id, status: 'active' })
      .populate('category', 'name icon description')
      .populate('seller', 'username email phone');

    if (!product) {
      return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
    }

    // Tăng view count (optional)
    // product.viewCount = (product.viewCount || 0) + 1;
    // await product.save();

    return successResponse(res, 'Lấy thông tin sản phẩm thành công', product);
  } catch (error) {
    console.error('Get product error:', error);
    return errorResponse(res, 'Không thể lấy thông tin sản phẩm', 500);
  }
};

// Sản phẩm theo category
const getProductsByCategory = async (req, res) => {
  try {
    const { categoryId } = req.params;
    const { page = 1, limit = 20 } = req.query;

    const products = await Product.find({
      category: categoryId,
      status: 'active'
    })
      .populate('category', 'name icon')
      .sort('-createdAt')
      .limit(parseInt(limit))
      .skip((page - 1) * parseInt(limit));

    const total = await Product.countDocuments({ category: categoryId, status: 'active' });

    return successResponse(res, 'Lấy sản phẩm theo danh mục thành công', {
      products,
      total,
      page: parseInt(page),
      totalPages: Math.ceil(total / parseInt(limit))
    });
  } catch (error) {
    console.error('Get products by category error:', error);
    return errorResponse(res, 'Không thể lấy sản phẩm theo danh mục', 500);
  }
};

// Sản phẩm nổi bật
const getFeaturedProducts = async (req, res) => {
  try {
    const products = await Product.find({
      isFeatured: true,
      status: 'active'
    })
      .populate('category', 'name icon')
      .populate('seller', 'username email phone') // ← THÊM DÒNG NÀY
      .sort('-rating -soldCount')
      .limit(10);

    return successResponse(res, 'Lấy sản phẩm nổi bật thành công', { products });
  } catch (error) {
    console.error('Get featured products error:', error);
    return errorResponse(res, 'Không thể lấy sản phẩm nổi bật', 500);
  }
};
// Lấy 6 sản phẩm ngẫu nhiên
const getRandomProducts = async (req, res) => {
  try {
    const randomProducts = await Product.aggregate([
      { $match: { status: 'active' } },
      { $sample: { size: 6 } },
      {
        $lookup: {
          from: 'categories', // Giả sử collection category là 'categories'
          localField: 'category',
          foreignField: '_id',
          as: 'category'
        }
      },
      { $unwind: { path: '$category', preserveNullAndEmptyArrays: true } },
      {
        $project: {
          category: {
            name: '$category.name',
            icon: '$category.icon'
          }
        }
      }
    ]);

    return successResponse(res, 'Lấy sản phẩm ngẫu nhiên thành công', { products: randomProducts });
  } catch (error) {
    console.error('Get random products error:', error);
    return errorResponse(res, 'Không thể lấy sản phẩm ngẫu nhiên', 500);
  }
};

// Sản phẩm liên quan
const getRelatedProducts = async (req, res) => {
  try {
    const { productId } = req.params;

    const product = await Product.findById(productId);
    if (!product) {
      return errorResponse(res, 'Không tìm thấy sản phẩm', 404);
    }

    // Lấy sản phẩm cùng category
    const relatedProducts = await Product.find({
      category: product.category,
      _id: { $ne: productId }, // Không bao gồm sản phẩm hiện tại
      status: 'active'
    })
      .populate('category', 'name icon')
      .populate('seller', 'username email')
      .limit(6)
      .sort('-rating');

    return successResponse(res, 'Lấy sản phẩm liên quan thành công', {
      relatedProducts
    });
  } catch (error) {
    console.error('Get related products error:', error);
    return errorResponse(res, 'Không thể lấy sản phẩm liên quan', 500);
  }
};

module.exports = {
  getProducts,
  getProductById,
  getProductsByCategory,
  getFeaturedProducts,
  getRandomProducts,
  getRelatedProducts
};