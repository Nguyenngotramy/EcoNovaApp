const Order = require('../../models/order.model');
const Product = require('../../models/seller/product.model');

/**
 * =============================
 * CREATE ORDER (BUYER)
 * =============================
 */
exports.createOrder = async (req, res) => {
  try {
    console.log('REQ.USER:', req.user);

    const { products } = req.body;

    if (!products || products.length === 0) {
      return res.status(400).json({ message: 'Products is required' });
    }

    const firstProduct = await Product.findById(products[0].productId);

    if (!firstProduct) {
      return res.status(400).json({ message: 'Product not found' });
    }

    console.log('SELLER ID:', firstProduct.sellerId);

    console.log('Order model: ', Order);

    const order = new Order({
      ...req.body,
      buyerId: req.user.id,          // 👈 giờ mới KHÔNG undefined
      sellerId: firstProduct.seller
    });

    await order.save();

    res.status(201).json({
      message: 'Order created successfully',
      order,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


/**
 * =============================
 * GET ORDERS OF BUYER
 * =============================
 */
exports.getOrders = async (req, res) => {
  try {
    const orders = await Order.find({ buyerId: req.user.id })
      .populate('sellerId', 'username')
      .populate({
        path: 'products.productId',
        select: 'name images price'
      })
      .sort({ createdAt: -1 });

    res.json(orders);
    const userId = req.user._id;
    console.log("UserId:", userId, "Type:", typeof userId);

    console.log("Orders:", orders);

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

