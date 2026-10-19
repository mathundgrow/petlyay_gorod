

import 'package:pocketbase/pocketbase.dart';

class PbClient {
  // Статическое поле, к которому мы будем обращаться отовсюду
  static final PocketBase instance = PocketBase('http://127.0.0.1:8090');
}

