import 'package:flutter/gestures.dart'; // Обязательно импортируй это!
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_city/core/widgets/app_button.dart';
import 'package:walk_city/core/widgets/custom_text_field.dart';
import 'package:walk_city/core/widgets/password_text_field.dart';
import 'package:walk_city/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:walk_city/features/auth/presentation/bloc/auth_event.dart';
import 'package:walk_city/features/auth/presentation/bloc/auth_state.dart';
import 'package:walk_city/features/auth/presentation/widgets/auth_title.dart';
import 'package:walk_city/features/auth/presentation/widgets/buttons/social_buttons_row.dart';
import 'package:walk_city/features/auth/presentation/widgets/or_divider.dart';
import 'package:walk_city/features/home/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Созданы контроллеры для полей ввода
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Убиваем контроллеры, когда уходим с экрана
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // если все в порядке - перекидываем в само приложение
          if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }

          // Слушаем: Если Блок крикнул "ОШИБКА"
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Stack(
          children: [
            Positioned(child: Image.asset("assets/images/auth/bg_city.png")),

            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 37.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          // ЛОГО

                          AuthTitle(pinkText: "гуляй", blackText: "Город"),

                          const SizedBox(height: 47),

                          // ЗАГОЛОВОК
                          const Text(
                            "С ВОЗВРАЩЕНИЕМ!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const Text(
                            "Войдите в свой аккаунт",
                            style: TextStyle(color: Colors.black87),
                          ),

                          const SizedBox(height: 40),

                          // ПОЛЯ (Используем компонент)
                          CustomTextField(
                            hint: "Email или телефон",
                            icon: Icons.email_outlined,
                            controller: _emailController,
                          ),

                          const SizedBox(height: 22),

                          PasswordTextField(
                            hint: "Пароль",
                            prefixIcon: Icons.lock_outline,
                            controller: _passwordController,
                          ),

                          const SizedBox(height: 11),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                // Убираем минимальный размер (те самые 48px)
                                minimumSize: Size.zero,

                                // Убираем внутренние отступы
                                padding: EdgeInsets.zero,

                                // Ужимаем зону нажатия
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                "Забыли пароль?",
                                style: TextStyle(color: Colors.pink),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // SizedBox(height: 10),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              
                              // ! позже переделать (возможно)
                              if (state is AuthLoading) {
                                // Показываем крутилку
                                return const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.pink,
                                    ),
                                  ),
                                );
                              }

                              return AppButton(
                                height: 60,

                                text: "ВОЙТИ",
                                onTap: () {
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text
                                      .trim();

                                  // Проверяем на пустоту поля
                                  if (email.isEmpty || password.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Пожалуйста, заполните все поля!",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  // ПРОШЛИ ВСЕ ПРОВЕРКИ - КИДАЕМ КОНВЕРТ В BLOC!
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      email: email,
                                      password: password,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 32),

                          const OrDivider(text: "или войти через"),

                          const SizedBox(height: 20),

                          // СОЦСЕТИ (Используем компонент)
                          const SocialButtonsRow(),

                          const SizedBox(height: 18),

                          Text.rich(
                            TextSpan(
                              style: const TextStyle(fontSize: 16),
                              children: [
                                const TextSpan(
                                  text: "Нет аккаунта? ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: "Зарегистрироваться",
                                  style: const TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // Добавляем магию клика:
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("Переход на экран регистрации!");
                                      // Тут будет переход: Navigator.push(...)
                                    },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 26),

                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Продолжая, вы соглашаетесь с ",
                                ),

                                TextSpan(
                                  text:
                                      "Пользовательским соглашением Политикой конфиденциальности",
                                  style: const TextStyle(color: Colors.pink),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("Нажали на соглашение");
                                      // Тут будет переход: Navigator.push(...)
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
