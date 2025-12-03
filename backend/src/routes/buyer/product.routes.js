const express = require('express');
const router = express.Router();
const productController = require('../../controllers/buyer/product.controller');

// Các route cố định trước
router.get('/featured', productController.getFeaturedProducts);
router.get('/category/:categoryId', productController.getProductsByCategory);
router.get('/related/:productId', productController.getRelatedProducts);

// Route danh sách sản phẩm
router.get('/', productController.getProducts);

// Route chi tiết sản phẩm (đặt cuối cùng)
router.get('/:id', productController.getProductById);

module.exports = router;
