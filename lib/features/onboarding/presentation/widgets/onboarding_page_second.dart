import 'package:flutter/material.dart';
import 'package:walk_city/features/onboarding/presentation/widgets/onboarding_card.dart';
import 'package:walk_city/features/onboarding/presentation/widgets/onboarding_description.dart';
import 'package:walk_city/features/onboarding/presentation/widgets/onboarding_title.dart';

// ? добавить еще лапки и позади карточек какую то херь

class OnboardingPageSecond extends StatelessWidget {
  const OnboardingPageSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Если это отдельная картинка, растягиваем её на весь экран

        Positioned(
          top: 5,
          right: -35,
          child: SizedBox(
            height: 205,
            width: 231,
            child: Image.asset(
              'assets/images/onboarding/halftone_bg.png',
              fit: BoxFit.contain,
            ),
          ),
        ),

        Positioned(
          left: 0, // Растягиваем левый край до упора
          right: 0, // Растягиваем правый край до упора
          child: Image.asset(
            'assets/images/onboarding/halftone_bg2.png',
            width: 150,
          ),
        ),

        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnboardingTitle(
                  mainText: "город\n",
                  pinkText: "ждет тебя",
                  isCentered: false,
                ),

                SizedBox(height: 12),

                OnboardingDescription(
                  text: "Пройди путь и стань частью городского сообщества",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),

                SizedBox(height: 36),

                OnboardingCard(
                  iconPath: "assets/images/onboarding/mapPinArea.png",
                  title: "Исследуй город",
                  desc: "Открывай новые места Новокузнецка",
                ),

                SizedBox(height: 23),

                OnboardingCard(
                  iconPath: "assets/images/onboarding/notepad.png",
                  title: "Выполняй задания",
                  desc: "Решай загадки, находи подсказки, получай баллы",
                ),

                SizedBox(height: 23),

                OnboardingCard(
                  iconPath: "assets/images/onboarding/gift.png",
                  title: "Получай награды",
                  desc: "Открывай новые места Новокузнецка",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
