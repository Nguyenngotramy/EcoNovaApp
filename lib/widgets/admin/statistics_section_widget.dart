
import 'package:flutter/material.dart';
import 'stat_card_widget.dart';
import 'section_header_widget.dart';

class StatisticsSectionWidget extends StatelessWidget {
  const StatisticsSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderWidget(title: 'Tổng quan'),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: StatCardWidget(
                  title: 'Người dùng',
                  value: '1,234',
                  icon: Icons.people_outline,
                  color: Color(0xFF043915),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: StatCardWidget(
                  title: 'Đơn hàng',
                  value: '567',
                  icon: Icons.shopping_bag_outlined,
                  color: Color(0xFF4C763B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: StatCardWidget(
                  title: 'Doanh thu',
                  value: '23.5M',
                  icon: Icons.attach_money,
                  color: Color(0xFF043915),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: StatCardWidget(
                  title: 'Sản phẩm',
                  value: '890',
                  icon: Icons.inventory_2_outlined,
                  color: Color(0xFFFF9800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}