import 'package:flutter/material.dart';
import 'package:walk_city/features/auth/presentation/palette.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.palette, required this.onTap});

  final Palette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.pink,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        child: const Text('СОХРАНИТЬ'),
      ),
    );
  }
}