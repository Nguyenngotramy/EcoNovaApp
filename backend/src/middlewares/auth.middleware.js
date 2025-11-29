const jwt = require('jsonwebtoken');
const { errorResponse } = require('../utils/response.util');

// Middleware xác thực JWT token
const authenticateToken = (req, res, next) => {
  try {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Bearer TOKEN

    if (!token) {
      return errorResponse(res, 'Token không hợp lệ', 401);
    }

    jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key-here', (err, user) => {
      if (err) {
        return errorResponse(res, 'Token đã hết hạn hoặc không hợp lệ', 403);
      }

      req.user = user; // { id, email, role, ... }
      next();
    });
  } catch (error) {
    console.error('Auth middleware error:', error);
    return errorResponse(res, 'Lỗi xác thực', 500);
  }
};

// Middleware kiểm tra role
const checkRole = (...roles) => {
  return (req, res, next) => {
    if (!req.user) {
      return errorResponse(res, 'Không có thông tin người dùng', 401);
    }

    if (!roles.includes(req.user.role)) {
      return errorResponse(res, 'Bạn không có quyền truy cập', 403);
    }

    next();
  };
};

module.exports = {
  authenticateToken,
  checkRole
};