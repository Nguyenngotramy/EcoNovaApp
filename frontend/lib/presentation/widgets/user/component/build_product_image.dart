import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
Widget buildProductImage({
  required String imageUrl,
  double? width,
  double height = 200.0,
  BoxFit fit = BoxFit.cover,
  Color? placeholderColor,
}) {
  final fallbackUrl = 'https://via.placeholder.com/${width?.toInt() ?? 300}x${height.toInt()}.png?text=No+Image';
  
  return Container(
    width: width ?? double.infinity, 
    height: height,
    decoration: BoxDecoration(
      color: placeholderColor ?? Colors.grey[200],
      borderRadius: BorderRadius.circular(12.0), // Adjust theo design
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl.isNotEmpty ? imageUrl : fallbackUrl,
        fit: fit,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // Màu loading phù hợp theme
            strokeWidth: 2.0,
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                size: 40.0,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Không tải được ảnh',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4.0),
              Text(
                '${error.toString().substring(0, 30)}...', // Truncate error message
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
