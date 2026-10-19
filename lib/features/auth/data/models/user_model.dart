class UserModel {
  final String id;
  final String email;
  final String name;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  // Этот метод превращает "сырой" JSON от сервера в Dart-объект
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  // Этот метод превращает Dart-объект в JSON для отправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
    };
  }
}