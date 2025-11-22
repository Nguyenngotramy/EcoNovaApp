import "package:flutter/material.dart";
import "./models/Product1.dart";
import "widgets/user/cart/ProductItemCard.dart";

class Cart extends StatelessWidget{
  Cart({super.key});
  final List<Product> shoppingCart = [
    Product(
      imageUrl: 'https://benhvienauco.com.vn/wp-content/uploads/2025/01/ca_chua_beff_2.jpg',
      name: 'Cà chua bi organic',
      quantity: 1,
      price: 45000,
      count: 1,
    ),
    Product(
      imageUrl: 'https://bizweb.dktcdn.net/100/390/808/products/20190405141327hat-giong-cai-bo-xoi.jpg?v=1593856342497',
      name: 'Rau cải bó xôi',
      quantity: 0.5,
      price: 32000,
      count: 2,
    ),
    Product(
      imageUrl: 'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2024_5_10_638509569529494648_cong-dung-cua-khoai-tay-thumb.jpg',
      name: 'Khoai tây',
      quantity: 0.5,
      price: 30000,
      count: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Icon back bên trái
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Xử lý khi nhấn nút back
            Navigator.pop(context);
          },
        ),

        // Text ở giữa
        title:  Text(
          'Giỏ hàng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // căn giữa tiêu đề

        // Icon bên phải
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Xử lý khi nhấn nút bên phải
              print('Selection icon pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
                  child: Center(
                    child: Text("${shoppingCart.length} sản phẩm"),
                  ),
                ),
                // Product List
                Container(
                  child: Column(
                    children: [
                      ...shoppingCart.map((product) {
                        return ProductItemCard(
                          product: product,
                        );
                      }).toList(),
                    ],
                  )

                ),

                // Thiếu progress bar
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF44AB1B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x91B3FFCB),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Icon(
                                        Icons.discount,
                                        color: Color(0xFFFFFFFF),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 290,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Ưu đãi đặc biệt",
                                                style: TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0x45FFFFFF),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                                  child: Center(
                                                    child: Text(
                                                        "Còn 20.000đ",
                                                        style: TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontSize: 9,
                                                        ),
                                                    ),
                                                  ),
                                              )
                                            )
                                          ]
                                        ),
                                      ),
                                      Container(
                                        width: 290,
                                        child: Text(
                                            "Mua thêm 20.000đ để nhận được mã giảm giá 15% cho đơn từ 200.000đ",
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 12,

                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container()
                        ],
                      ),
                  )

                ),

                Text(
                    "Có thể bạn quan tâm",
                    textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF043915),
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  )
                ),
                // maybe you like - list
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        height: 240,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7FAF3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFD2D2D2),
                            width: 0.5,
                          )
                        ),
                      )
                    ]
                  ),
                )
            ]
          ),
        ),
      )
    );
  }
}

