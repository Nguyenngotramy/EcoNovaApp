import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeaderWidget({
    Key? key,
    required this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
