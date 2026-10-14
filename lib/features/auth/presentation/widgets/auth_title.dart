import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String pinkText;
  final String blackText;
  final double fontSize;
  final bool isAllBlack; // Новый параметр

  const AuthTitle({
    super.key,
    required this.pinkText,
    required this.blackText,
    this.fontSize = 40, // По умолчанию false (как было раньше)
    this.isAllBlack = false,
  });

  @override
  Widget build(BuildContext context) {
    // Определяем цвета на основе флага
    final pinkColor = isAllBlack ? Colors.black : const Color(0xFFE5397F);
    final blackColor = Colors.black;

    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900),
        children: [
          TextSpan(
            text: "${pinkText.toUpperCase()} ",
            style: TextStyle(color: pinkColor), // Цвет меняется сам
          ),
          
          TextSpan(
            text: blackText.toUpperCase(),
            style: TextStyle(color: blackColor),
          ),
        ],
      ),
    );
  }
}
