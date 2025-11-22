import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class OrderTimelineItem extends StatelessWidget {
  final String title;
  final String time;
  final String? description;
  final bool isCompleted;
  final bool isLast;
  final IconData icon;

  const OrderTimelineItem({
    Key? key,
    required this.title,
    required this.time,
    this.description,
    required this.isCompleted,
    required this.isLast,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isCompleted 
                      ? AppTheme.primary 
                      : AppTheme.cardBackground,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? AppTheme.primary : AppTheme.borderColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: isCompleted ? AppTheme.background : AppTheme.textLight,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isCompleted 
                          ? AppTheme.primary.withOpacity(0.3)
                          : AppTheme.borderColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isCompleted ? AppTheme.textPrimary : AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: AppTheme.caption.copyWith(color: AppTheme.textLight),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      description!,
                      style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}