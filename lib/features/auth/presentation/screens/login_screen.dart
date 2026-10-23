import 'package:flutter/gestures.dart'; // Обязательно импортируй это!
import 'package:flutter/material.dart';
import 'package:walk_city/core/widgets/app_button.dart';
import 'package:walk_city/core/widgets/custom_text_field.dart';
import 'package:walk_city/core/widgets/password_text_field.dart';
import 'package:walk_city/features/auth/presentation/screens/register_screen.dart';
import 'package:walk_city/features/auth/presentation/widgets/auth_title.dart';
import 'package:walk_city/features/auth/presentation/widgets/buttons/social_buttons_row.dart';
import 'package:walk_city/features/auth/presentation/widgets/or_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                        const CustomTextField(
                          hint: "Email или телефон",
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 22),

                        const PasswordTextField(
                          hint: "Пароль",
                          prefixIcon: Icons.lock_outline,
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
                        AppButton(
                          height: 60,

                          text: "ДАЛЕЕ",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
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
    );
  }
}
