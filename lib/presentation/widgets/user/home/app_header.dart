import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:eco_nova_app/presentation/screens/user/cart_screen.dart';
import 'package:eco_nova_app/presentation/widgets/user/cart/badge_icon_button.dart';
import 'package:flutter/material.dart';

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
          BadgeIconButton(
            icon: Icons.notifications_outlined,
            badgeCount: 1,
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          BadgeIconButton(
            icon: Icons.shopping_cart_outlined,
            badgeCount: 1,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}