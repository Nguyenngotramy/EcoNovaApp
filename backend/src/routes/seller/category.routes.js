const express = require('express');
const router = express.Router();
const categoryController = require('../../controllers/seller/category.controller');
const { authenticateToken, checkRole } = require('../../middlewares/auth.middleware');
const { categoryUpload } = require('../../config/cloudinary.config'); // Adjust path to your cloudinary config file (e.g., '../../config/cloudinary')

// Tất cả routes đều yêu cầu authentication và role seller
router.use(authenticateToken);
router.use(checkRole('seller'));

// GET /api/seller/categories - Lấy tất cả categories
router.get('/', categoryController.getAllCategories);

// GET /api/seller/categories/:id - Lấy chi tiết category
router.get('/:id', categoryController.getCategoryById);

// POST /api/seller/categories - Tạo category mới (with optional icon upload)
router.post('/', categoryUpload.single('icon'), categoryController.createCategory);

// PUT /api/seller/categories/:id - Cập nhật category (with optional icon upload)
router.put('/:id', categoryUpload.single('icon'), categoryController.updateCategory);

// DELETE /api/seller/categories/:id - Xóa category
router.delete('/:id', categoryController.deleteCategory);

// Optional: Separate upload route for category icon (if you prefer pre-upload)
// POST /api/seller/categories/upload-category - Upload icon only, returns URL
router.post('/upload-category', categoryUpload.single('icon'), (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ 
        success: false, 
        message: 'Không có file icon được upload' 
      });
    }
    res.status(200).json({
      success: true,
      message: 'Upload icon thành công',
      url: req.file.path // Cloudinary URL
    });
  } catch (error) {
    console.error('Upload category icon error:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Lỗi khi upload icon' 
    });
  }
});

module.exports = router;