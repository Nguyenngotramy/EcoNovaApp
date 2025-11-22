import 'package:flutter/material.dart';
import '../../screens/shipper/home_shipper_screen.dart';
import 'report/reports_home_screen.dart';
import 'deliveries/deliveries_list_screen.dart';
import 'profile/profile_screen.dart';

class MainShipperNavigation extends StatefulWidget {
  const MainShipperNavigation({super.key});

  @override
  State<MainShipperNavigation> createState() => _MainShipperNavigationState();
}

class _MainShipperNavigationState extends State<MainShipperNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeShipperScreen(),      // Dashboard
    ReportsHomeScreen(),      // Reports
    DeliveriesListScreen(),
    ProfileScreen(),
    Placeholder(),            // Deliveries
    Placeholder(),            // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,

        onTap: (i) => setState(() => currentIndex = i),

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Deliveries'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
