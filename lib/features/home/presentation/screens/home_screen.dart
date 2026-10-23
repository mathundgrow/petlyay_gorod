import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 10. АДЕКВАТНЫЙ NAVBAR
      bottomNavigationBar: _buildBottomNav(),

      body: Stack(
        children: [
          // 2. ФОН СТРАНИЦЫ (Подготовлен для твоей картинки)
          Positioned.fill(
            // Раскомментируй строку ниже и вставь свой путь к фону с розовыми пятнами
            // child: Image.asset('assets/images/home/bg_home.png', fit: BoxFit.cover),
            child: Container(
              color: Colors.white,
            ), // Пока картинки нет, тут белый цвет
          ),

          SafeArea(
            child: SingleChildScrollView(
              // 6. ОТСТУПЫ СТРАНИЦЫ 16 ПИКСЕЛЕЙ
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // ШАПКА
                  _buildCustomAppBar(),
                  const SizedBox(height: 30),

                  // 1. ИСПРАВЛЕННЫЙ ЗАГОЛОВОК (Без Overflow)
                  _buildSectionHeader(
                    title: "ЛЕГЕНДА ДНЯ",
                    actionWidget: _buildTimePill(),
                  ),
                  const SizedBox(height: 15),

                  // КАРТОЧКА ЛЕГЕНДЫ
                  _buildLegendCard(),
                  const SizedBox(height: 20),

                  // 7. УМЕНЬШЕННАЯ ПЛАШКА "ПОДЕЛИТЬСЯ"
                  _buildShareBanner(),
                  const SizedBox(height: 30),

                  // АФИША (Заголовок)
                  _buildSectionHeader(
                    title: "АФИША",
                    actionWidget: const Text(
                      "Смотреть все >",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ГОРИЗОНТАЛЬНЫЙ СПИСОК АФИШИ
                  _buildAfishaList(),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.nightlight_round, size: 28),
        const Text(
          "ГЛАВНАЯ",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        Stack(
          children: [
            const Icon(Icons.notifications_none, size: 30),
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required Widget actionWidget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center, // Выравниваем по центру
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        actionWidget,
      ],
    );
  }

  Widget _buildTimePill() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ), // Сделал отступы меньше
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      // Уменьшил шрифт до 10, чтобы точно не было Overflow
      child: const Text(
        "Сменится через: 12ч. 32мин.",
        style: TextStyle(
          color: Colors.pink,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLegendCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                // 4. ВЫСОТА КАРТИНКИ (Измени значение height, если нужно еще меньше/больше)
                child: Container(
                  height: 140,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
                // Раскомментируй и вставь фото крепости:
                // child: Image.asset('путь_к_фото', height: 140, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ), // Уменьшил отступы
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // 3. @USERNAME СДЕЛАЛ МЕНЬШЕ (fontSize: 9)
                  child: const Text(
                    "@USERNAME",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 9,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Кузнецкая крепость",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                // 5. LINE-HEIGHT УМЕНЬШЕН (height: 1.2)
                const Text(
                  "Рассказываем, как деревянный острог превратился в каменный бастион и почему его пушки так и остались мирными...",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "ЧИТАТЬ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatPill(Icons.favorite, "15.6k"),
                    const SizedBox(width: 4),
                    _buildStatPill(Icons.chat_bubble, "1200"),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.reply,
                        color: Colors.pink,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.pink, size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildShareBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.camera_alt, color: Colors.pink, size: 18),
          ),
          const SizedBox(width: 10),
          // УМЕНЬШИЛ ТЕКСТ ДО 11
          const Expanded(
            child: Text(
              "Поделитесь своей легендой",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.pink.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Добавить легенду",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAfishaList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip
                  .none, // Позволяет плашке "лекция" вылезать за пределы картинки
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Container(
                            height: 90,
                            width: double.infinity,
                            color: Colors.grey.shade400,
                          ),
                          // Раскомментируй для фото:
                          // child: Image.asset('путь', height: 90, width: double.infinity, fit: BoxFit.cover),
                        ),
                        // 8. ЦИФРЫ КРАСНЫЕ, МЕСЯЦ ЧЕРНЫЙ
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  "24",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    color: Colors.pink,
                                  ),
                                ),
                                Text(
                                  "мая",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Отступ под картинкой (специально больше, чтобы влезла плашка)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 14.0,
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "История Сибири в деталях",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              height: 1.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.pink,
                                size: 10,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "Краеведческий музей",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey.shade600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // 9. ПЛАШКА "ЛЕКЦИЯ" НАЕЗЖАЕТ НА ФОТО
                Positioned(
                  top: 80, // Высота картинки (90) минус половина высоты плашки
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "лекция",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- 10. АДЕКВАТНЫЙ NAVBAR ---
  Widget _buildBottomNav() {
    return Container(
      height: 85,
      padding: const EdgeInsets.only(
        bottom: 15,
        top: 10,
      ), // Место под полоску айфона
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(Icons.home_filled, "Главная", isActive: true),
          _navItem(Icons.assignment_outlined, "Задания"),
          _navItem(Icons.map_outlined, "Карта"),
          _navItem(Icons.shopping_bag_outlined, "Магазин"),
          _navItem(Icons.person_outline, "Профиль"),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? Colors.pink.shade50 : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.pink : Colors.black,
            size: 24,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? Colors.pink : Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
