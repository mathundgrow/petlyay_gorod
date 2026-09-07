import 'package:flutter/material.dart';

class OnboardingTitle extends StatelessWidget {
  final String mainText;
  final String pinkText;
  final bool isCentered;

  OnboardingTitle({
    super.key,
    required String mainText,
    required String pinkText,
    this.isCentered = false,
  }) : mainText = mainText.toUpperCase(),
      pinkText = pinkText.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 54,
          height: 0.9,

          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: mainText,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              letterSpacing: -4.5,
            ),
          ),

          TextSpan(
            text: pinkText,
            style: TextStyle(
              color: Color.fromRGBO(220, 57, 120, 1),
              letterSpacing: -5,
            ),
          ),
        ],
      ),

      textAlign: isCentered ? TextAlign.center : TextAlign.start,
    );
  }
}
