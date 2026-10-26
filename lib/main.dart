import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:walk_city/core/network/pb_client.dart';
import 'package:walk_city/features/auth/data/repositories/auth_repository.dart';
import 'package:walk_city/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:walk_city/features/auth/presentation/screens/avatar_screen.dart';
import 'package:walk_city/features/auth/presentation/screens/login_screen.dart';

void main() async {
  // перед началом инициализируй подключение к серверу
  WidgetsFlutterBinding.ensureInitialized();

  final PocketBase pb = PbClient.instance;

  try {
    final result = await pb.health.check();
    debugPrint("Сервер ответил: ${result.code}");
  } catch (e) {
    debugPrint("Ошибка подключения: $e");
  }

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AvatarScreen(),
    );
  }
}
