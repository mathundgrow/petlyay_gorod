import 'package:flutter/material.dart';
import 'package:walk_city/features/auth/presentation/widgets/buttons/social_button.dart';

// Импортируй созданный SocialButton

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Список путей к иконкам (пока везде ВК)
    final List<String> icons = [
      'assets/images/auth/vk_icon.png',
      'assets/images/auth/vk_icon.png',
      'assets/images/auth/vk_icon.png',
      'assets/images/auth/vk_icon.png',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Центрируем весь ряд
      // Генерируем список виджетов
      children: List.generate(icons.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ), // Отступы МЕЖДУ кнопками
          child: SocialButton(
            iconPath: icons[index],
            // Пример: делаем последнюю кнопку с синей рамкой, как на скрине
            borderColor: index == 3 ? Colors.blue : Colors.grey.shade400,
            onTap: () {
              print("Нажата соцсеть №$index");
            },
          ),
        );
      }),
    );
  }
}
