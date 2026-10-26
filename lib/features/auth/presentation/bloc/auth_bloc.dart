import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_city/features/auth/data/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  // Конструктор: Блок, при создании должен знать про свой Репозиторий
  AuthBloc(this._repository) : super(AuthInitial()) {
    // МАРШРУТИЗАТОР: "Если придет LoginEvent, тогда надо в _onLogin"
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  // ОБРАБОТЧИК ЛОГИНА
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Сразу кричим "ЗАГРУЗКА"

    try {
      // Идем к "Почтальону" (репозиторию)
      final user = await _repository.login(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(user: user)); // Кричим "УСПЕХ"
    } catch (e) {
      String errorMessage = "Произошла ошибка при входе.";

      final errorString = e.toString();

      // Сервер возвращает 400 Failed to authenticate
      if (errorString.contains("Failed to authenticate")) {
        errorMessage = "Неверный email или пароль.";
      }
      // Если сервер выключен или нет интернета
      else if (errorString.contains("ClientException") &&
          !errorString.contains("response:")) {
        errorMessage = "Нет связи с сервером. Проверьте интернет.";
      }

      // Выдаем красивую ошибку
      emit(AuthFailure(message: errorMessage));
    }
  }

  // ОБРАБОТЧИК РЕГИСТРАЦИИ
  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    // меняем состояние на новое
    emit(AuthLoading());

    try {
      final user = await _repository.register(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      emit(AuthSuccess(user: user));
    } catch (e) {
      // переводим ошибку на человеческий язык
      String errorMessage = "Произошла ошибка при регистрации.";

      final errorString = e.toString();

      // Если сервер ругается на email
      if (errorString.contains("validation_is_email")) {
        errorMessage = "Введите правильный формат email!";
      }
      // Если email уже есть в базе
      else if (errorString.contains("validation_not_unique")) {
        errorMessage = "Пользователь с таким email уже существует!";
      }
      // ? Если пароль слишком короткий (хотя мы это уже проверяем в UI)
      else if (errorString.contains("validation_length")) {
        errorMessage = "Пароль слишком короткий!";
      }

      emit(AuthFailure(message: errorMessage));
    }
  }
}
