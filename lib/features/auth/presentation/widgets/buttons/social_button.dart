import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String iconPath; // Путь к картинке из assets
  final VoidCallback onTap; // Действие по клику
  final Color
  borderColor; // Чтобы можно было сделать синюю рамку, как на макете

  const SocialButton({
    super.key,
    required this.iconPath,
    required this.onTap,
    this.borderColor = Colors.grey, // По умолчанию рамка серая
  });

  @override
  Widget build(BuildContext context) {
    // Используем Material + InkWell для красивого "живого" клика
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16), // Скругление как на макете
      child: Ink(
        width: 70,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          
          // Чтобы эффект клика не был слишком ярким:
          splashColor: Colors.grey.withValues(alpha: 0.2),
          highlightColor: Colors.grey.withValues(alpha: 0.1),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 30, // Размер самой иконки внутри рамки
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
