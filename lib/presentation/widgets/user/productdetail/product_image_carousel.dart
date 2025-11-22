import 'package:flutter/material.dart';

class ProductImageCarousel extends StatefulWidget {
  final String heroTag;
  final String mainImage;

  const ProductImageCarousel({
    Key? key,
    required this.heroTag,
    required this.mainImage,
  }) : super(key: key);

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentIndex = 0;
  late List<String> images;

  @override
  void initState() {
    super.initState();
    // Main image + additional images
    images = [
      widget.mainImage,
      'https://picsum.photos/400/300?random=2',
      'https://picsum.photos/400/300?random=3',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return Hero(
                  tag: widget.heroTag,
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                );
              }
              return Image.network(
                images[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
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