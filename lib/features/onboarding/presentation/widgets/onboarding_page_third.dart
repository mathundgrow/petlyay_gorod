import 'package:flutter/material.dart';
import 'package:walk_city/features/onboarding/presentation/widgets/onboarding_description.dart';
// Проверь свои пути к импортам!
import 'package:walk_city/features/onboarding/presentation/widgets/onboarding_title.dart';

class OnboardingPageThird extends StatelessWidget {
  const OnboardingPageThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/onboarding/cat_final.png',
            fit: BoxFit.cover,

            alignment: Alignment.topCenter,
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
            
                OnboardingTitle(mainText: "ГОТОВЫ\n", pinkText: "НАЧАТЬ?"),
            
                const SizedBox(height: 20),
            
                OnboardingDescription(
                  text: "Твой путь по Новокузнецку начинается прямо сейчас",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
