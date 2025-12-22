const express = require('express');
const router = express.Router();

const orderController = require('../../controllers/buyer/order.controller');
const { authenticateToken } = require('../../middlewares/auth.middleware');

// Buyer
router.post('/', authenticateToken, orderController.createOrder);
router.get('/', authenticateToken, orderController.getOrders);

module.exports = router;
