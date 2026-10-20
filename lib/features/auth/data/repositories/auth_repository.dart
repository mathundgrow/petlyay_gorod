import 'package:walk_city/core/network/pb_client.dart';
import 'package:walk_city/features/auth/data/models/user_model.dart';

class AuthRepository {
  // единственный путь к серваку
  final _pb = PbClient.instance;

  // Метод регистрации
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

    // Стучимся на сервер ( нам приходит в переменную Record model - у нее есть поля всякие, мы обращаемся к .data - то есть данным которые мы ток что написали)
    final record = await _pb.collection('users').create(body: body);
    
    // Возвращаем модель
    return UserModel.fromJson(record.data);
  }

  // Метод логина
  Future<UserModel> login({required String email, required String password}) async {
    final authData = await _pb.collection('users').authWithPassword(email, password);
    
    return UserModel.fromJson(authData.record.data);
  }
  
}