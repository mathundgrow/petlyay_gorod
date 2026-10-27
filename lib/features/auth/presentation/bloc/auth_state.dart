import 'package:equatable/equatable.dart';
import 'package:walk_city/features/auth/data/models/user_model.dart';

// Базовый класс состояний
abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

// 1. Начальное состояние (когда только открыли экран)
class AuthInitial extends AuthState {}

// 2. Состояние "В процессе" (показываем крутилку)
class AuthLoading extends AuthState {}

// 3. Состояние "Успех" (мы получили юзера с сервера)
class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

// 4. Состояние "Ошибка" (надо показать всплывашку с текстом ошибки)
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}