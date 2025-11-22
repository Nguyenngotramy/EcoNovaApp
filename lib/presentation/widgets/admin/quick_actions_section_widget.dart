import 'package:eco_nova_app/presentation/widgets/admin/quick_action_item_widget.dart';
import 'package:flutter/material.dart';

import 'section_header_widget.dart';

class QuickActionsSectionWidget extends StatelessWidget {
  const QuickActionsSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderWidget(title: 'Thao tác nhanh'),
          const SizedBox(height: 16),
          QuickActionItemWidget(
            title: 'Duyệt sản phẩm chờ xác nhận',
            subtitle: '12 sản phẩm đang chờ',
            icon: Icons.approval_outlined,
            badge: '12',
            onTap: () => print('Duyệt sản phẩm'),
          ),
          QuickActionItemWidget(
            title: 'Xử lý khiếu nại khẩn cấp',
            subtitle: '3 khiếu nại cần xử lý',
            icon: Icons.priority_high,
            badge: '3',
            onTap: () => print('Xử lý khiếu nại'),
          ),
          QuickActionItemWidget(
            title: 'Xem báo cáo ngày hôm nay',
            subtitle: 'Cập nhật 5 phút trước',
            icon: Icons.analytics_outlined,
            onTap: () => print('Xem báo cáo'),
          ),
        ],
      ),
    );
  }
}