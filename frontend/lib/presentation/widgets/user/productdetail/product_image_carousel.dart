// lib/presentation/widgets/user/productdetail/product_image_carousel.dart (Updated to accept full images list)
import 'package:flutter/material.dart';
import 'package:eco_nova_app/presentation/widgets/user/component/build_product_image.dart';

class ProductImageCarousel extends StatefulWidget {
  final String heroTag;
  final List<String> images; // Full list from product

  const ProductImageCarousel({
    Key? key,
    required this.heroTag,
    required this.images,
  }) : super(key: key);

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentIndex = 0;
  late List<String> _images;

  @override
  void initState() {
    super.initState();
    _images = widget.images.isNotEmpty ? widget.images : ['https://via.placeholder.com/400x300.png?text=No+Image'];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Hero(
                tag: '${widget.heroTag}_$index', // Unique tag for each image
                child: buildProductImage(
                  imageUrl: _images[index],
                  height: 300,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}