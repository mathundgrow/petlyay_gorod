import 'package:flutter/material.dart';
import 'package:walk_city/features/auth/presentation/palette.dart';

/// Поле для ввода данных в окне изменения пароля.
/// Имеет свое название, подсказку и иконку в виде виджета внутри текстового поля.
class LabeledField extends StatelessWidget {
  const LabeledField(
    {super.key, 
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    required this.palette,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onTap,
    this.onSubmitted,
  });

  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final Palette palette;

  /// Виджет справа внутри поля (иконка «i», «глаз»…).
  final Widget? suffix;

  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: palette.ink,
          ),
        ),
        const SizedBox(height: 7),

        Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: palette.fieldFill,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: palette.fieldBorder, width: 1.2),
          ),
          child: Row(
            children: [
              Icon(prefixIcon, size: 20, color: palette.hint),
              const SizedBox(width: 10),

              // Expanded — TextField обязан получить ограничение по ширине,
              // иначе он не знает, какой ширины быть, и падает с ошибкой.
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  autofillHints: autofillHints,
                  onTap: onTap,
                  onSubmitted: onSubmitted,
                  cursorColor: palette.pink,
                  // Для паролей отключаем автоподсказки и автокоррекцию.
                  enableSuggestions: !obscureText,
                  autocorrect: !obscureText,
                  style: TextStyle(fontSize: 14, color: palette.ink),
                  // decoration описывает ВСЁ оформление поля.
                  // Мы рисуем рамку сами (Container выше), поэтому здесь
                  // ставим border: InputBorder.none и убираем внутренние отступы.
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: palette.hint,
                    ),
                  ),
                ),
              ),

              if (suffix != null) suffix!,
            ],
          ),
        ),
      ],
    );
  }
}