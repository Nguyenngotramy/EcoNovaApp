import 'package:eco_nova_app/screens/chat_list_screen.dart';
import 'package:eco_nova_app/screens/my_orders_screen.dart';
import 'package:eco_nova_app/screens/myaccount_screen.dart';
import 'package:eco_nova_app/screens/search_screen.dart';
import 'package:eco_nova_app/theme/app_theme.dart';
import 'package:eco_nova_app/widgets/bottom_nav_bar.dart';
import 'package:eco_nova_app/widgets/chat/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'screens/home_user_screen.dart';  // Import file mới

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoNova',
      theme: AppTheme.lightTheme,
      home: MainScreen(),  
    );
  }
}
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