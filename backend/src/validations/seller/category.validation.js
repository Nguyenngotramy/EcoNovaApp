const { body, validationResult } = require('express-validator');

exports.categoryValidation = {
  create: [
    body('name')
      .trim()
      .notEmpty().withMessage('Tên danh mục không được để trống')
      .isLength({ min: 2, max: 100 }).withMessage('Tên danh mục phải từ 2-100 ký tự'),
    
    body('description')
      .optional()
      .trim()
      .isLength({ max: 500 }).withMessage('Mô tả không được quá 500 ký tự'),
    
    body('icon')
      .optional()
      .isURL().withMessage('Icon phải là URL hợp lệ'),
    
    body('displayOrder')
      .optional()
      .isInt({ min: 0 }).withMessage('Thứ tự hiển thị phải là số >= 0'),
    
    body('isActive')
      .optional()
      .isBoolean().withMessage('isActive phải là true/false'),
    
    // Middleware xử lý validation errors
    (req, res, next) => {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({
          success: false,
          message: 'Dữ liệu không hợp lệ',
          errors: errors.array(),
        });
      }
      next();
    },
  ],

  update: [
    body('name')
      .optional()
      .trim()
      .isLength({ min: 2, max: 100 }).withMessage('Tên danh mục phải từ 2-100 ký tự'),
    
    body('description')
      .optional()
      .trim()
      .isLength({ max: 500 }).withMessage('Mô tả không được quá 500 ký tự'),
    
    body('icon')
      .optional()
      .isURL().withMessage('Icon phải là URL hợp lệ'),
    
    body('displayOrder')
      .optional()
      .isInt({ min: 0 }).withMessage('Thứ tự hiển thị phải là số >= 0'),
    
    body('isActive')
      .optional()
      .isBoolean().withMessage('isActive phải là true/false'),
    
    (req, res, next) => {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({
          success: false,
          message: 'Dữ liệu không hợp lệ',
          errors: errors.array(),
        });
      }
      next();
    },
  ],
};