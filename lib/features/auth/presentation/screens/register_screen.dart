import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walk_city/core/widgets/app_button.dart';
import 'package:walk_city/core/widgets/custom_text_field.dart';
import 'package:walk_city/core/widgets/password_text_field.dart';
import 'package:walk_city/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:walk_city/features/auth/presentation/bloc/auth_event.dart';
import 'package:walk_city/features/auth/presentation/bloc/auth_state.dart';
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

  // Созданы контроллеры для полей ввода
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  // Убиваем их, когда уходим с экрана (как делали с PageController)
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {

          // Слушаем: Если Блок крикнул "УСПЕХ"
          if (state is AuthSuccess) {
            
            // ВОТ ТЕПЕРЬ ПЕРЕХОДИМ!
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AvatarScreen()),
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


        // старый код продолжается тут
        child: Stack(
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
                    CustomTextField(
                      hint: "Имя",
                      icon: Icons.person_outline,
                      controller: _nameController,
                    ),

                    const SizedBox(height: 22),

                    CustomTextField(
                      hint: "Email или телефон",
                      icon: Icons.email_outlined,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 22),

                    // На экране логина:
                    PasswordTextField(
                      hint: "Пароль",
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordController,
                    ),

                    const SizedBox(height: 22),

                    // На экране логина:
                    PasswordTextField(
                      hint: "Повторный пароль",
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordConfirmController,
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
                        if (!_isChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Примите условия!")),
                          );
                          return;
                        }

                        // Добавлены простые проверки, чтобы не слать пустые данные на сервер
                        if (_nameController.text.isEmpty ||
                            _emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Заполните все поля!"),
                            ),
                          );
                          return;
                        }

                        // КНОПКА ТОЛЬКО ОТПРАВЛЯЕТ СОБЫТИЕ. И ВСЁ.
                        context.read<AuthBloc>().add(
                          RegisterEvent(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
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
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
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
      ),
    );
  }
}
