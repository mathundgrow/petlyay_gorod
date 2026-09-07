import 'package:flutter/material.dart';

class OnboardingDescription extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const OnboardingDescription({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        height: 1.17,
        fontWeight: fontWeight,
        letterSpacing: 0,
      ),
    );
    
  }
}
