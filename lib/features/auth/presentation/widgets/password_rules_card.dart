import 'package:flutter/material.dart';
import 'package:walk_city/features/auth/presentation/palette.dart';

class PasswordRulesCard extends StatelessWidget {
  const PasswordRulesCard({super.key, required this.palette});

  final Palette palette;

  static const List<String> _rules = [
    'Минимум 8 символов',
    'Заглавные и строчные буквы',
    'Цифры и специальные символы',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: palette.cardFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Пароль должен содержать:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: palette.cardText,
            ),
          ),
          const SizedBox(height: 10),

          // Список собираем через map -> List<Widget>.
          for (final rule in _rules)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•',
                    style: TextStyle(fontSize: 12, color: palette.cardText),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      rule,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.3,
                        color: palette.cardText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}