import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.location_city, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Giao hàng đến',
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Lo 14, Khu đô thị Nam Việt Á',
                        style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
                  ],
                ),
                Text(
                  'Ngu Hành Sơn, Đà Nẵng',
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _buildBadgeIconButton(
            icon: Icons.notifications_outlined,
            badgeCount: 1,
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          _buildBadgeIconButton(
            icon: Icons.shopping_cart_outlined,
            badgeCount: 1,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeIconButton({
    required IconData icon,
    required int badgeCount,
    required VoidCallback onPressed,
  }) {
    return Stack(
      children: [
        IconButton(
          iconSize: 28,
          icon: Icon(icon, color: AppTheme.textLight),
          onPressed: onPressed,
        ),
        if (badgeCount > 0)
          Positioned(
            right: 4,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(2),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                badgeCount.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}