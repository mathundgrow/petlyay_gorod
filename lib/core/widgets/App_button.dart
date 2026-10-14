import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  
  // Оставляем только то, что реально меняется
  final double height;
  final double fontSize;

  const AppButton({
    super.key, 
    required this.text, 
    required this.onTap,
    // Дефолтные значения (под Онбординг)
    this.height = 76,
    this.fontSize = 26,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Чтобы углы не были белыми
      child: Ink(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(220, 57, 120, 1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50), // Чтобы волна была круглой
          child: SizedBox(
            height: height,
            width: double.infinity, // Кнопка занимает всю ширину, которую ей дают
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  letterSpacing: 1, // Зафиксировали интервал
                  // fontWeight: FontWeight.normal (по умолчанию он и так regular)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}