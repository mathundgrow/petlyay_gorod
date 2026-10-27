import 'package:equatable/equatable.dart';

// Базовый класс для всех событий авторизации
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// 1. Событие: Пользователь хочет войти
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// 2. Событие: Пользователь хочет зарегистрироваться
class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const RegisterEvent({required this.email, required this.password, required this.name});

  @override
  List<Object> get props => [email, password, name];
}