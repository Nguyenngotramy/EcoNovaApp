import 'package:eco_nova_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';


// Component: Chat Badge
class ChatBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const ChatBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.secondaryLight.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: backgroundColor ?? AppTheme.secondaryDark,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTheme.caption.copyWith(
          color: textColor ?? AppTheme.secondaryDark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Component: Unread Badge (Red dot)
class UnreadBadge extends StatelessWidget {
  const UnreadBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: AppTheme.errorColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

// Component: Chat List Item
class ChatListItem extends StatelessWidget {
  final String shopName;
  final String shopImage;
  final String lastMessage;
  final String time;
  final String? badge; // 'Bao cũ', 'Trái cây', 'Cũ qua', 'Nấm'
  final bool hasUnread;
  final VoidCallback? onTap;

  const ChatListItem({
    super.key,
    required this.shopName,
    required this.shopImage,
    required this.lastMessage,
    required this.time,
    this.badge,
    this.hasUnread = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.borderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  shopImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.cardBackground,
                      child: const Icon(
                        Icons.store_outlined,
                        color: AppTheme.textLight,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Chat Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          shopName,
                          style: AppTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (badge != null) ...[
                        ChatBadge(label: badge!),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread) ...[
                        const SizedBox(width: 8),
                        const UnreadBadge(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}