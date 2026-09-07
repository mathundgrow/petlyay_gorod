import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const OnboardingButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(220, 57, 120, 1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 76,
              width: double.infinity,
              child: Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 26,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    letterSpacing: 1,
                  ),
                  text,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
