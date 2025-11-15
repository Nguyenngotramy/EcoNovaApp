import 'package:flutter/material.dart';
import 'screens/home_user.dart';  // Import file mới

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeUserScreen(),  
    );
  }
}