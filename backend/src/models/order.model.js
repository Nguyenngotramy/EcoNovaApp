const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
  buyerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },

  sellerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },

  products: [
    {
      productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product',
        required: true
      },
      quantity: Number,
      price: Number,
      size: String
    }
  ],

  status: {
    type: String,
    default: 'pending'
  },

  total: Number
}, { timestamps: true });

module.exports = mongoose.model('Order', orderSchema);