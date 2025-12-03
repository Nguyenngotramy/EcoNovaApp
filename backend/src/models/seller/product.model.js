const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  description: {
    type: String,
    required: true
  },
  // Chi tiết mô tả đầy đủ cho trang product detail
  detailedDescription: {
    type: String,
    default: ''
  },
  // Thông tin dinh dưỡng
  nutritionInfo: {
    calories: { type: String, default: '' },
    protein: { type: String, default: '' },
    carbs: { type: String, default: '' },
    fat: { type: String, default: '' },
    fiber: { type: String, default: '' },
    vitamins: { type: String, default: '' }
  },
  // Hướng dẫn bảo quản
  storageInstructions: {
    type: String,
    default: ''
  },
  // Xuất xứ
  origin: {
    type: String,
    default: ''
  },
  // Hạn sử dụng (số ngày)
  shelfLife: {
    type: Number,
    default: null
  },
  category: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Category',
    required: true
  },
  seller: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  salePrice: {
    type: Number,
    required: true,
    min: 0
  },
  originalPrice: {
    type: Number,
    default: null
  },
  discount: {
    type: Number,
    min: 0,
    max: 100,
    default: 0
  },
  stock: {
    type: Number,
    required: true,
    min: 0,
    default: 0
  },
  weight: {
    type: Number,
    required: true
  },
  unit: {
    type: String,
    enum: ['kg', 'gram', 'túi', 'bó', 'trái', 'lon', 'chai', 'hộp'],
    required: true
  },
  sku: {
    type: String,
    unique: true,
    sparse: true
  },
  isOrganic: {
    type: Boolean,
    default: false
  },
  isFeatured: {
    type: Boolean,
    default: false
  },
  // Badges/Tags
  badges: [{
    type: String,
    enum: ['bestseller', 'new', 'sale', 'organic', 'fresh', 'imported']
  }],
  images: [{
    type: String
  }],
  rating: {
    type: Number,
    default: 0,
    min: 0,
    max: 5
  },
  reviewCount: {
    type: Number,
    default: 0
  },
  soldCount: {
    type: Number,
    default: 0
  },
  status: {
    type: String,
    enum: ['active', 'inactive', 'out_of_stock'],
    default: 'active'
  }
}, {
  timestamps: true
});

// Validator for images array to ensure at least one image
productSchema.path('images').validate(function(images) {
  return images && images.length > 0;
}, 'Ít nhất phải có một ảnh sản phẩm.');

// Custom validator for salePrice >= originalPrice if originalPrice exists
productSchema.path('salePrice').validate(function(salePrice) {
  const originalPrice = this.originalPrice;
  if (originalPrice && salePrice < originalPrice) {
    return false;
  }
  return true;
}, 'Giá bán phải lớn hơn hoặc bằng giá gốc nếu có giá gốc.');

// Indexes
productSchema.index({ name: 'text', description: 'text' });
productSchema.index({ category: 1, status: 1 });
productSchema.index({ seller: 1 });
productSchema.index({ salePrice: 1 });
productSchema.index({ createdAt: -1 });

productSchema.pre('save', function() {
  if (this.stock === 0) {
    this.status = 'out_of_stock';
  } else if (this.status === 'out_of_stock' && this.stock > 0) {
    this.status = 'active';
  }
});

module.exports = mongoose.model('Product', productSchema);