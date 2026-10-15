import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:walk_city/features/auth/presentation/screens/login_screen.dart';
import 'package:walk_city/features/home/presentation/screens/home_screen.dart';
import 'package:walk_city/features/tasks/presentation/screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;

// Инициализируем клиента
  final pb = PocketBase('http://127.0.0.1:8090');

  try {
    // Делаем простую проверку здоровья сервера
    final result = await pb.health.check();
    print("Сервер ответил: ${result.code}");
  } catch (e) {
    print("Ошибка подключения: $e");
  }

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
