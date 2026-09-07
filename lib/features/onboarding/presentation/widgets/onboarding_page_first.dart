import 'package:flutter/material.dart';
import 'package:walk_city/features/onboarding/presentation/widgets/onboarding_description.dart';
import 'package:walk_city/features/onboarding/presentation/widgets/onboarding_title.dart';

class OnboardingPageFirst extends StatelessWidget {
  const OnboardingPageFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Image.asset(
            'assets/images/onboarding/cat_hi.png',
            fit: BoxFit.fitWidth,
          ),
        ),

        // оступ от картинки
        Transform.translate(
          offset: Offset(0, -20),
          child: Column(
            children: [
              OnboardingTitle(
                mainText: "Исследуй\n",
                pinkText: "новокузнецк",
                isCentered: true,
              ),

              SizedBox(height: 20),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 35),
                child: OnboardingDescription(
                  text:
                      "Проходи задания, открывай новые места и получай реальные призы",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
