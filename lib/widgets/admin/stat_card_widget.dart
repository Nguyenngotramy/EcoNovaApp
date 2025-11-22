import 'package:flutter/material.dart';

class StatCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCardWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF043915),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Be Vietnam Pro',
              fontSize: 12,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}