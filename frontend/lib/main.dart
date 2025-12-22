import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/admin/admin_dashboard_screen.dart';
import 'presentation/screens/admin/order_management_screen.dart';
import 'presentation/screens/admin/revenue_statistics_screen.dart';
import 'presentation/screens/admin/user_management_screen.dart';
import 'presentation/screens/auth/select_role_view.dart';
import 'presentation/screens/auth/signin_view.dart';
import 'presentation/screens/auth/signup_view.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';
import 'presentation/screens/seller/complete_order_list_screen.dart';
import 'presentation/screens/seller/product_list_screen.dart';
import 'presentation/screens/seller/seller_chat_list_screen.dart';
import 'presentation/screens/seller/seller_dashboard_screen.dart';
import 'presentation/screens/seller/seller_profile_screen.dart';
import 'presentation/screens/shipper/deliveries/deliveries_list_screen.dart';
import 'presentation/screens/shipper/home_shipper_screen.dart';
import 'presentation/screens/shipper/profile/profile_screen.dart';
import 'presentation/screens/shipper/report/reports_home_screen.dart';
import 'presentation/screens/user/chat_list_screen.dart';
import 'presentation/screens/user/home_user_screen.dart';
import 'presentation/screens/user/my_orders_screen.dart';
import 'presentation/screens/user/myaccount_screen.dart';
import 'presentation/screens/user/search_screen.dart';
import 'presentation/widgets/user/component/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoNova',
      theme: AppTheme.lightTheme,
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        // '/role': (context) => const RoleSelectionScreen(),
        '/user': (context) => const MainScreen(),
        '/seller': (context) => const MainScreenSeller(),
        '/shipper': (context) => const MainScreenShipper(),
        '/admin': (context) => const MainScreenAdmin(),
        "/signin": (context) => const SignInView(),
        "/selectRole": (context) => const SelectRoleView(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/signup") {
          final role = settings.arguments as String;

          return MaterialPageRoute(
            builder: (context) => SignUpView(role: role),
          );
        }
        return null;
      },
    );
  }
}

// ============== USER MAIN SCREEN ==============
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const MyOrdersScreen(),
    const ChatListScreen(),
    const MyAccountScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}

// ============== SELLER MAIN SCREEN ==============
class MainScreenSeller extends StatefulWidget {
  const MainScreenSeller({Key? key}) : super(key: key);

  @override
  State<MainScreenSeller> createState() => _MainScreenSellerState();
}

class _MainScreenSellerState extends State<MainScreenSeller> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    SellerDashboardScreen(),
    ProductListScreen(),
    CompleteOrderListScreen(),
    SellerChatListScreen(),
    SellerProfileScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SellerBottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}

// ============== SHIPPER MAIN SCREEN ==============
class MainScreenShipper extends StatefulWidget {
  const MainScreenShipper({Key? key}) : super(key: key);

  @override
  State<MainScreenShipper> createState() => _MainScreenShipperState();
}

class _MainScreenShipperState extends State<MainScreenShipper> {
  int _currentIndex = 0;

  // Fixed to 4 pages to match bottom nav items
  final List<Widget> _pages = [
    const HomeShipperScreen(),
    const ReportsHomeScreen(),
    const DeliveriesListScreen(),
    const ProfileScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ShipperBottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}

// ============== ADMIN MAIN SCREEN ==============
class MainScreenAdmin extends StatefulWidget {
  const MainScreenAdmin({Key? key}) : super(key: key);

  @override
  State<MainScreenAdmin> createState() => _MainScreenAdminState();
}

class _MainScreenAdminState extends State<MainScreenAdmin> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AdminDashboardScreen(),
    const UserManagementScreen(),
    const OrderManagementScreen(),
    const RevenueStatisticsScreen(),
    const AdminSettings(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: AdminBottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}

// ============== ADMIN SCREENS ==============

class AdminSettings extends StatelessWidget {
  const AdminSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 80, color: Colors.red),
          SizedBox(height: 16),
          Text('Cài đặt',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Cấu hình hệ thống và chính sách.'),
        ],
      ),
    );
  }
}

// ============== BOTTOM NAV BARS ==============
class SellerBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const SellerBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabChanged,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2), label: 'Products'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class ShipperBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const ShipperBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabChanged,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(
            icon: Icon(Icons.description), label: 'Reports'),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping), label: 'Deliveries'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class AdminBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const AdminBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabChanged,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.analytics), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
