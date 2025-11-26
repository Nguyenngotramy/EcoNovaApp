const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../models/User');
const router = express.Router();

// Register (B-01: full name stub username, license, role từ Flutter)
router.post('/register', async (req, res) => {
  try {
    const { username, email, phone, password, license, role } = req.body;
    const existingUser = await User.findOne({ $or: [{ email }, { phone }] });
    if (existingUser) return res.status(400).json({ error: 'User tồn tại' });

    const user = new User({ username, email, phone, password, license, role });
    await user.save();

    const otp = user.generateOTP();
    console.log(`OTP cho ${phone}: ${otp}`);  // Stub - thay SMS/Email real (Twilio)

    res.status(201).json({ message: 'Đăng ký OK, kiểm tra OTP', userId: user._id });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Verify OTP (kích hoạt user, trả token)
router.post('/verify-otp', async (req, res) => {
  try {
    const { userId, otp } = req.body;
    const user = await User.findById(userId);
    if (!user || user.otp !== otp || Date.now() > user.otpExpiry) {
      return res.status(400).json({ error: 'OTP sai/hết hạn' });
    }

    user.isVerified = true;
    user.otp = undefined;
    user.otpExpiry = undefined;
    await user.save();

    const token = jwt.sign({ id: user._id, role: user.role }, process.env.JWT_SECRET, { expiresIn: '24h' });
    res.json({ message: 'Xác thực OK', token, role: user.role });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Login (B-02: email/phone, multi-device stub)
router.post('/login', async (req, res) => {
  try {
    const { email, phone, password, deviceId } = req.body;
    const user = await User.findOne({ $or: [{ email }, { phone }] });
    if (!user || !(await user.comparePassword(password)) || !user.isVerified) {
      return res.status(401).json({ error: 'Sai thông tin hoặc chưa verify' });
    }

    const token = jwt.sign({ id: user._id, role: user.role, deviceId }, process.env.JWT_SECRET, { expiresIn: '24h' });
    user.devices.push({ deviceId, lastActive: new Date(), token });
    user.devices = user.devices.slice(-3);  // Max 3 devices
    await user.save();

    // Auto-logout stub (idle 30p)
    setTimeout(() => console.log(`Auto-logout ${deviceId}`), 30 * 60 * 1000);

    res.json({ token, user: { id: user._id, username: user.username, role: user.role } });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;