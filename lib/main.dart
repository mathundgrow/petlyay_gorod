import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:walk_city/core/network/pb_client.dart';
import 'package:walk_city/features/auth/data/repositories/auth_repository.dart';
import 'package:walk_city/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:walk_city/features/auth/presentation/screens/login_screen.dart';
import 'package:walk_city/features/home/presentation/screens/home_screen.dart';

void main() async {
  // перед началом инициализируй подключение к серверу
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем клиента и ждем, пока он прочитает диск
  await PbClient.init();

  final PocketBase pb = PbClient.instance;

  // ТИХОЕ ОБНОВЛЕНИЕ ТОКЕНА
  if (pb.authStore.isValid) {
    try {
      
      // Пытаемся обновить токен в фоне
      await pb.collection('users').authRefresh();
      debugPrint("Токен успешно обновлен в фоне!");
    } catch (e) {
      // Если сервер сказал - токен недействителен (ex: юзера забанили в админке)
      debugPrint("Токен протух или недействителен. Очищаем.");
      
      // Стираем плохой токен с диска!
      pb.authStore.clear(); 
    }
  }

  // ? (потом убрать) Достаем токен из нашего единственного экземпляра клиента
  final token = PbClient.instance.authStore.token;
  final isValid = PbClient.instance.authStore.isValid;

  // Печатаем в консоль
  print("====================================");
  print("СТАТУС АВТОРИЗАЦИИ: $isValid");
  if (token.isNotEmpty) {
    print("ТОКЕН НАЙДЕН: $token");
  } else {
    print("ТОКЕНА НЕТ (Пусто)");
  }
  print("====================================");

  // пытаемся подключиться к серверу
  try {
    final result = await pb.health.check();
    debugPrint("Сервер ответил: ${result.code}");
  } catch (e) {
    debugPrint("Ошибка подключения: $e");
  }

  PbClient.instance.authStore.clear();

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
      home: PbClient.instance.authStore.isValid
          ? const HomeScreen() // Если токен жив - на Главную
          : const LoginScreen(), // Иначе - логинимся
    );
  }
}
