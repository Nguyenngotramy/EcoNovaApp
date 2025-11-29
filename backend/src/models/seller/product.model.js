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
  price: {
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
    enum: ['kg', 'gram', 'túi', 'bó', 'trái'],
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
  images: [{
    type: String,
    required: true
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

// Indexes
productSchema.index({ name: 'text', description: 'text' });
productSchema.index({ category: 1, status: 1 });
productSchema.index({ seller: 1 });
productSchema.index({ price: 1 });
productSchema.index({ createdAt: -1 });

// Auto update status dựa vào stock
productSchema.pre('save', function(next) {
  if (this.stock === 0) {
    this.status = 'out_of_stock';
  } else if (this.status === 'out_of_stock' && this.stock > 0) {
    this.status = 'active';
  }
  next();
});

module.exports = mongoose.model('Product', productSchema);