const express = require('express');
const router = express.Router();
const categoryController = require('../../controllers/seller/category.controller');
const { authenticateToken, checkRole } = require('../../middlewares/auth.middleware');

// Tất cả routes đều yêu cầu authentication và role seller
router.use(authenticateToken);
router.use(checkRole('seller'));

// GET /api/seller/categories - Lấy tất cả categories
router.get('/', categoryController.getAllCategories);

// GET /api/seller/categories/:id - Lấy chi tiết category
router.get('/:id', categoryController.getCategoryById);

// POST /api/seller/categories - Tạo category mới
router.post('/', categoryController.createCategory);

// PUT /api/seller/categories/:id - Cập nhật category
router.put('/:id', categoryController.updateCategory);

// DELETE /api/seller/categories/:id - Xóa category
router.delete('/:id', categoryController.deleteCategory);

module.exports = router;