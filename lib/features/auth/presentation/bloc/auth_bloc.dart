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
      emit(AuthFailure(message: e.toString())); // Кричим "ОШИБКА"
    }
  }

  // ОБРАБОТЧИК РЕГИСТРАЦИИ
  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _repository.register(
        email: event.email, 
        password: event.password, 
        name: event.name,
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}