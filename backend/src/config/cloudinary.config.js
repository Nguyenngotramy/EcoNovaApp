const cloudinary = require('cloudinary').v2;
const CloudinaryStorage = require('multer-storage-cloudinary');
const multer = require('multer');


cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET
});


const productStorage = new CloudinaryStorage({
  cloudinary: cloudinary,
  params: {
    folder: 'eco_nova/products', // Folder trong Cloudinary
    allowed_formats: ['jpg', 'jpeg', 'png', 'webp', 'gif'],
    transformation: [{ 
      width: 800, 
      height: 800, 
      crop: 'limit', // Giữ tỷ lệ, không crop
      quality: 'auto' // Auto optimize quality
    }]
  }
});


const categoryStorage = new CloudinaryStorage({
  cloudinary: cloudinary,
  params: {
    folder: 'eco_nova/categories',
    allowed_formats: ['jpg', 'jpeg', 'png', 'webp', 'svg'],
    transformation: [{ 
      width: 512, 
      height: 512, 
      crop: 'limit',
      quality: 'auto'
    }]
  }
});

const productUpload = multer({ 
  storage: productStorage,
  limits: { 
    fileSize: 5 * 1024 * 1024 
  }
});

const categoryUpload = multer({
  storage: categoryStorage,
  limits: {
    fileSize: 5 * 1024 * 1024 
  }
});

module.exports = {
  cloudinary,
  categoryUpload,
  productUpload
};