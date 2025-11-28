const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema({
  username: { type: String, unique: true, required: true },
  email: { type: String, unique: true, required: true },
  phone: { type: String, unique: true, required: true },
  password: { type: String, required: true },
  license: String,  // License No. cho seller/shipper
  role: { type: String, enum: ['buyer', 'seller', 'shipper'], default: 'buyer' },
  devices: [{ deviceId: String, lastActive: Date, token: String }],
  isVerified: { type: Boolean, default: false },
  otp: String,
  otpExpiry: Date,
}, { timestamps: true });

userSchema.pre('save', async function() {
  if (!this.isModified('password')) return;

  this.password = await bcrypt.hash(this.password, 10);
});


userSchema.methods.comparePassword = async function(password) {
  return await bcrypt.compare(password, this.password);
};

userSchema.methods.generateOTP = function() {
  this.otp = Math.floor(100000 + Math.random() * 900000).toString();
  this.otpExpiry = Date.now() + 5 * 60 * 1000;
  return this.otp;
};

module.exports = mongoose.model('User', userSchema);