import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:walk_city/core/network/pb_client.dart';
import 'package:walk_city/features/auth/data/models/user_model.dart';

class AuthRepository {
  final _pb = PbClient.instance;

  // после регистрации сразу логинимся и возвращаем модель юзера
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final body = {
      "email": email,
      "password": password,
      "passwordConfirm": password,
      "name": name,
    };

    // 1 Создаем юзера в базе
    await _pb.collection('users').create(body: body);
    
    // 2 сразу логинимся (Чтобы получить токен и сохранить сессию)
    return await login(email: email, password: password);
  }

  // загружаем аватарку на сервер (в коллекцию users)
  Future<void> uploadAvatar(File imageFile) async {
    // Достаем ID текущего залогиненного пользователя из authStore
    final userId = _pb.authStore.record!.id;

    // Отправляем файл на сервер
    await _pb.collection('users').update(
      userId,
      files: [
        await http.MultipartFile.fromPath('avatar', imageFile.path),
      ],
    );
  }


  // Метод логина
  Future<UserModel> login({required String email, required String password}) async {
    final authData = await _pb.collection('users').authWithPassword(email, password);
    
    return UserModel.fromJson(authData.record.data);
  }
  
}