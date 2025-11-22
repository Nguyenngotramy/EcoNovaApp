import "package:eco_nova_app/data/models/product_v1.dart";
import "package:flutter/material.dart";


class ProductItemCard extends StatelessWidget {
  ProductItemCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border.all(
            color: Color(0xFFD2D2D2),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ]
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0xFF043915),
                                    ),
                                  ),
                                  Text(
                                    "Định lượng: ${product.quantity}kg",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  "${product.price}VNĐ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4C763B),
                                    fontSize: 13,
                                  )
                              ),
                            ]
                        )
                    ),
                  ],
                ),
              ),
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => print("Pressed"),
                          child: Icon(Icons.delete, size: 24, color: Colors.red),
                        ),
                        Container(
                            width: 100,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () => print("Pressed"),
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Color(0xFFF3F3F3),
                                          ),

                                          child: Center(
                                            child: Icon(Icons.remove, size: 20, color: Color(0xFF4C763B)),
                                          )
                                      )
                                  ),
                                  Text(
                                    product.count.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),

                                  ),
                                  GestureDetector(
                                      onTap: () => print("Pressed"),
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Color(0xFF4C763B),
                                          ),

                                          child: Center(
                                            child: Icon(Icons.add, size: 20, color: Color(0xFFFFFFFF)),
                                          )
                                      )
                                  ),
                                ]
                            )
                        )
                      ]
                  )
              )
            ]
        ),
      ),
    );
  }
}