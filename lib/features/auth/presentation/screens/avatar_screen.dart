import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:walk_city/core/widgets/App_button.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. ФОН (Заглушка)
          Positioned.fill(
            child: Image.asset("assets/images/auth/bg_avatar.png"),
          ),

          // 1. ФОН (Заглушка)
          Positioned(
            bottom: 0, // Приклеили к низу
            left: 0, // Растянули от края до края
            right: 0, // Растянули от края до края
            child: Image.asset(
              "assets/images/auth/bg_bottom.png",
              alignment: Alignment
                  .bottomCenter, // Центрируем саму картинку внутри её области
              fit: BoxFit.contain, // Чтобы картинка не обрезалась
            ),
          ),

          // 2. КОНТЕНТ
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // ЗАГОЛОВОК
                  const Text(
                    "УСТАНОВИ АВАТАР",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  const Text(
                    "Выбери изображение, которое будет\nпредставлять тебя в городе",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 95),

                  // КРУГ ДЛЯ АВАТАРКИ (Пункт 1 из задания)
                  DottedBorder(
                    options: const CircularDottedBorderOptions(
                      color: Colors.pink,
                      strokeWidth: 2,
                      dashPattern: [8, 4],
                      strokeCap: StrokeCap.round,
                    ),
                    // Делаем кругом

                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      width: 250,
                      height: 250,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.pink,
                            ),
                            SizedBox(height: 10),

                            Text(
                              "ДОБАВИТЬ ФОТО",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            Text(
                              "Нажми, чтобы выбрать изображение",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 70),

                  // СОВЕТ (Пункт 2 из задания)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lightbulb_outline,
                          color: Colors.pink,
                          size: 44,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Прижимаем текст влево
                            children: [
                              Text("СОВЕТ"),
                              Text(
                                "Используй фото, по которому тебя легко узнать другим участникам!",
                              ), // Он теперь не вылезет за экран
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ... верхняя часть с аватаром без изменений ...
                  const Spacer(),

                  // КНОПКА
                  AppButton(
                    height: 60,
                    text: "СОХРАНИТЬ",
                    onTap: () {
                      print("Сохраняем аватар!");
                    },
                  ),
                  const SizedBox(height: 20),
                  // ...
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
