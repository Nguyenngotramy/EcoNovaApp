const express = require('express');
const router = express.Router();
const productController = require('../../controllers/seller/product.controller');
const { authenticateToken, checkRole } = require('../../middlewares/auth.middleware');
const { productUpload } = require('../../config/cloudinary.config');  // Import upload cho products

// Auth middleware cho tất cả routes
router.use(authenticateToken);
router.use(checkRole('seller'));

// GET /api/seller/products - Lấy tất cả sản phẩm
router.get('/', productController.getSellerProducts);

// GET /api/seller/products/:id - Lấy chi tiết sản phẩm
router.get('/:id', productController.getProductById);

// POST /api/seller/products - Tạo sản phẩm mới (hỗ trợ 1-10 ảnh)
router.post('/', productUpload.array('images', 10), productController.createProduct);

// PUT /api/seller/products/:id - Cập nhật sản phẩm (hỗ trợ thêm 1-10 ảnh mới)
router.put('/:id', productUpload.array('images', 10), productController.updateProduct);

// DELETE /api/seller/products/:id - Xóa sản phẩm
router.delete('/:id', productController.deleteProduct);

// Optional: Route riêng upload single image (nếu cần cho icon hoặc standalone)
router.post('/upload-product', productUpload.single('icon'), (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ 
        success: false, 
        message: 'Không có file được upload' 
      });
    }
    res.status(200).json({
      success: true,
      message: 'Upload thành công',
      url: req.file.path // Cloudinary URL
    });
  } catch (error) {
    console.error('Upload error:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Lỗi khi upload' 
    });
  }
});

module.exports = router;