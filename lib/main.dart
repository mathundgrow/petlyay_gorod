import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:walk_city/core/network/pb_client.dart';
import 'package:walk_city/features/tasks/presentation/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final PocketBase pb = PbClient.instance;

  try {
    final result = await pb.health.check();
    debugPrint("Сервер ответил: ${result.code}");
  } catch (e) {
    debugPrint("Ошибка подключения: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TasksScreen(),
    );
  }
}
