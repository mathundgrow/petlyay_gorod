import 'package:flutter/material.dart';
import 'package:walk_city/features/auth/presentation/screens/login_screen.dart';
import 'package:walk_city/features/home/presentation/screens/home_screen.dart';
import 'package:walk_city/features/tasks/presentation/tasks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
