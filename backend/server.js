const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const multer = require('multer');
const path = require('path');
require('dotenv').config();

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Static files (uploads)
app.use('/uploads', express.static('uploads'));

// Database connection - XÓA useNewUrlParser và useUnifiedTopology
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/vegetable-shop')
  .then(() => {
    console.log('✅ Mongo connected');
    console.log('👉 URI:', process.env.MONGODB_URI || 'LOCALHOST');
  })
  .catch(err => console.error('❌ MongoDB connection error:', err));

// ===== ROUTES =====
const authRoutes = require('./src/routes/auth');
const categoryRoutes = require('./src/routes/seller/category.routes');
const productRoutes = require('./src/routes/seller/product.routes');
// Auth routes
app.use('/api/auth', authRoutes);

// Seller routes (cần auth + role seller)
app.use('/api/seller/categories', categoryRoutes);
app.use('/api/seller/products', productRoutes);

const buyerProductRoutes = require('./src/routes/buyer/product.routes');
const orderRoutes = require('./src/routes/buyer/order.routes');
app.use('/api/products', buyerProductRoutes);
app.use('/api/orders', orderRoutes);

// Health check
app.get('/api/health', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Server is running',
    timestamp: new Date().toISOString()
  });
});

// Test route
app.get('/api/test/categories', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Categories endpoint is accessible',
    note: 'Use /api/seller/categories with Bearer token for actual data'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ 
    success: false, 
    message: 'Route not found' 
  });
});

// Error handler
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(err.status || 500).json({
    success: false,
    message: err.message || 'Internal server error'
  });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server running on port ${PORT}`);
});