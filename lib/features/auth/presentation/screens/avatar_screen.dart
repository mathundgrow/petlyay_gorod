import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:walk_city/core/widgets/app_button.dart';
import 'package:walk_city/features/auth/data/repositories/auth_repository.dart';
import 'package:walk_city/features/home/presentation/screens/home_screen.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  // Тут будет лежать выбранная фотка
  File? _selectedImage;

  // Сам инструмент выбора
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    // 1 Открываем галерею телефона
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality:
          80, // Сжимаем качество до 80%, чтобы не грузить огромные файлы по 10 МБ
    );

    // 2 Если пользователь реально выбрал фотку (а не просто закрыл галерею крестиком)
    if (pickedFile != null) {
      setState(() {
        // Превращаем временный XFile в постоянный File и обновляем экран!
        _selectedImage = File(pickedFile.path);
      });
    }
  }

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

                  // круглая аватарка
                  GestureDetector(
                    onTap: _pickImage,
                    child: DottedBorder(
                      options: const CircularDottedBorderOptions(
                        color: Colors.pink,
                        strokeWidth: 2,
                        dashPattern: [8, 4],
                        strokeCap: StrokeCap.round,
                      ),
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,

                          // Если _selectedImage не пустой, ставим его фоном круга!
                          image: _selectedImage != null
                              ? DecorationImage(
                                  image: FileImage(_selectedImage!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _selectedImage == null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
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
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
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
                              )
                            : null,
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

                  const Spacer(),

                  // ryjgrf
                  AppButton(
                    height: 60,
                    text: "СОХРАНИТЬ",
                    onTap: () async {
                      // 1 Если фотка не выбрана — ругаемся
                      if (_selectedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Сначала выберите фотографию!"),
                          ),
                        );
                        return;
                      }

                      try {
                        
                        // Показываем пользователю - идет загрузка
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Загружаем аватарку на сервер..."),
                          ),
                        );

                        // 2 Вызываем репозиторий
                        final authRepo = AuthRepository();
                        await authRepo.uploadAvatar(_selectedImage!);

                        // 3. успешно - Переходим на Главную страницу
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) =>
                                false, // Очищаем историю, чтобы нельзя было вернуться назад
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Ошибка загрузки: $e"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
