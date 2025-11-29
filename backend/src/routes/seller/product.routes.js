const express = require('express');
const router = express.Router();
const productController = require('../../controllers/seller/product.controller');
const { authenticateToken, checkRole } = require('../../middlewares/auth.middleware');

// Tất cả routes đều yêu cầu authentication và role seller
router.use(authenticateToken);
router.use(checkRole('seller'));

// GET /api/seller/products - Lấy tất cả sản phẩm của seller
router.get('/', productController.getSellerProducts);

// GET /api/seller/products/:id - Lấy chi tiết sản phẩm
router.get('/:id', productController.getProductById);

// POST /api/seller/products - Tạo sản phẩm mới
router.post('/', productController.createProduct);

// PUT /api/seller/products/:id - Cập nhật sản phẩm
router.put('/:id', productController.updateProduct);

// PATCH /api/seller/products/:id/status - Cập nhật trạng thái
router.patch('/:id/status', productController.updateProductStatus);

// DELETE /api/seller/products/:id - Xóa sản phẩm
router.delete('/:id', productController.deleteProduct);

module.exports = router;