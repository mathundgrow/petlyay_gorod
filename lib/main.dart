import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:walk_city/features/auth/presentation/screens/login_screen.dart';
import 'package:walk_city/features/home/presentation/screens/home_screen.dart';
import 'package:walk_city/features/tasks/presentation/tasks_screen.dart';

import 'core/network/pb_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;

// Инициализируем клиента
  final PocketBase pb = PbClient.instance;

  try {
    // Делаем простую проверку здоровья сервера
    final result = await pb.health.check();
    print("Сервер ответил: ${result.code}");
  } catch (e) {
    print("Ошибка подключения: $e");
  }
  }