require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();

// Thêm middleware này (quan trọng - parse JSON body)
app.use(express.json({ limit: '10mb' }));  // Parse req.body JSON
app.use(cors({ origin: '*' }));  // Cho Postman/Flutter

// Connect MongoDB
mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('✅ MongoDB connected'))
  .catch(err => console.error('❌ Mongo error:', err));

// Routes
app.use('/api/auth', require('./src/routes/auth'));

// Test root
app.get('/', (req, res) => res.json({ message: 'Backend AgriVN Ready!' }));

const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => console.log(`Server running on port ${PORT}`));
