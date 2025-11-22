
import 'package:eco_nova_app/presentation/widgets/admin/management_section_widget.dart';
import 'package:eco_nova_app/presentation/widgets/admin/quick_actions_section_widget.dart';
import 'package:eco_nova_app/presentation/widgets/admin/statistics_section_widget.dart';
import 'package:flutter/material.dart';
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Quản trị hệ thống',
          style: TextStyle(
            fontFamily: 'Be Vietnam Pro',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF043915),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: const Color(0xFF043915),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            color: const Color(0xFF043915),
            onPressed: () {},
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            StatisticsSectionWidget(),
            ManagementSectionWidget(),
            QuickActionsSectionWidget(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}