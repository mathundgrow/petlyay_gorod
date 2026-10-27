import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PbClient {
  // late - "Я клянусь, что инициализирую эту переменную позже, до того как её используют"
  static late final PocketBase instance;

  // Метод инициализации (вызывается один раз при старте приложения)
  static Future<void> init() async {

    // 1 Подключение к жесткому диску телефона
    final prefs = await SharedPreferences.getInstance();

    // 2 создание "умного" хранилища для PocketBase
    final store = AsyncAuthStore(
      
      // Как сохранять: берем данные от PB и пишем на диск под ключом 'pb_auth'
      save: (String data) async => prefs.setString('pb_auth', data),

      // Как читать: при старте достаем данные с диска по ключу 'pb_auth'
      initial: prefs.getString('pb_auth'),
    );

    // 3 создание клиента и передача ему "умного" хранилища
    instance = PocketBase('http://127.0.0.1:8090', authStore: store);
    
  }
}