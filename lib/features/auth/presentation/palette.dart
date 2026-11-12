import 'package:flutter/material.dart';

class Palette {
  const Palette({
    required this.background,
    required this.ink,
    required this.hint,
    required this.fieldFill,
    required this.fieldBorder,
    required this.pink,
    required this.bannerFill,
    required this.bannerBorder,
    required this.bannerText,
    required this.cardFill,
    required this.cardText,
    required this.navBackground,
    required this.navInactive,
  });

  final Color background;
  final Color ink;
  final Color hint;
  final Color fieldFill;
  final Color fieldBorder;
  final Color pink;
  final Color bannerFill;
  final Color bannerBorder;
  final Color bannerText;
  final Color cardFill;
  final Color cardText;
  final Color navBackground;
  final Color navInactive;

  /// Выбор палитры по теме приложения.
  factory Palette.of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Palette.dark
        : Palette.light;
  }

  static const Palette light = Palette(
    background: Color(0xFFFFFFFF),
    ink: Color(0xFF111111),
    hint: Color(0xFF9C9C9C),
    fieldFill: Color(0xFFFFFFFF),
    fieldBorder: Color(0xFFE3E3E3),
    pink: Color(0xFFE5327C),
    bannerFill: Color(0xFFFBE2EC),
    bannerBorder: Color(0xFFF2AFCB),
    bannerText: Color(0xFFB01D5C),
    cardFill: Color(0xFFFCE7F0),
    cardText: Color(0xFF333333),
    navBackground: Color(0xFFFFFFFF),
    navInactive: Color(0xFF9E9E9E),
  );

  static const Palette dark = Palette(
    background: Color(0xFF2A1520),
    ink: Color(0xFFFFFFFF),
    hint: Color(0xFFA88B97),
    fieldFill: Color(0xFF3A2029),
    fieldBorder: Color(0xFF5B3A47),
    pink: Color(0xFFE5327C),
    bannerFill: Color(0xFF4A1E31),
    bannerBorder: Color(0xFFE5327C),
    bannerText: Color(0xFFFFD9E7),
    cardFill: Color(0xFF4B2434),
    cardText: Color(0xFFEFE0E6),
    navBackground: Color(0xFF1E0F16),
    navInactive: Color(0xFF9B7F8B),
  );
}