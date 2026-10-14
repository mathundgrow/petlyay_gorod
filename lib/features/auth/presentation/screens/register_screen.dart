import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:walk_city/core/widgets/App_button.dart';
import 'package:walk_city/core/widgets/custom_text_field.dart';
import 'package:walk_city/core/widgets/password_text_field.dart';
import 'package:walk_city/features/auth/presentation/screens/avatar_screen.dart';
import 'package:walk_city/features/auth/presentation/widgets/auth_title.dart';
import 'package:walk_city/features/auth/presentation/widgets/buttons/social_buttons_row.dart';
import 'package:walk_city/features/auth/presentation/widgets/custom_checkbox.dart';
import 'package:walk_city/features/auth/presentation/widgets/or_divider.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Фон (розовые точки)
          Positioned(
            child: Image.asset(
              'assets/images/auth/bg_top.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 45),

                  const AuthTitle(
                    pinkText: "",
                    blackText: "создай аккаунт",
                    isAllBlack: true,
                    fontSize: 28,
                  ),

                  const Text(
                    "и начинай исследовать!",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 37),

                  // ПОЛЯ ВВОДА
                  const CustomTextField(
                    hint: "Имя",
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 22),
                  const CustomTextField(
                    hint: "Email или телефон",
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 22),

                  // На экране логина:
                  const PasswordTextField(
                    hint: "Пароль",
                    prefixIcon: Icons.lock_outline,
                  ),

                  const SizedBox(height: 22),
                  
                  // На экране логина:
                  const PasswordTextField(
                    hint: "Повторный пароль",
                    prefixIcon: Icons.lock_outline,
                  ),

                  const SizedBox(height: 22),

                  // ЧЕКБОКС (Используем компонент)
                  Row(
                    children: [
                      CustomCheckbox(
                        value: _isChecked,
                        onChanged: (newValue) =>
                            setState(() => _isChecked = newValue),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Я принимаю условия пользовательского соглашения",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    height: 60,
                    text: "ДАЛЕЕ",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvatarScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // ДИВАЙДЕР
                  const OrDivider(text: "или зарегистрироваться через"),
                  const SizedBox(height: 11),

                  // СОЦСЕТИ
                  const SocialButtonsRow(),
                  const SizedBox(height: 18),

                  // самый нижний текст
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      children: [
                        const TextSpan(text: "Уже есть аккаунт? "),

                        // Кликабельная часть 1
                        TextSpan(
                          text: "Войти",
                          style: const TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
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
          ),
        ],
      ),
    );
  }
}
