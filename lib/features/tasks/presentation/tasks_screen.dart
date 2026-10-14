import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _selectedTab = 0; // 0 - Маршруты, 1 - Миссии

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(),

      body: Stack(
        children: [
          // ФОН ЭКРАНА
          Positioned.fill(
            // Раскомментируй строку ниже и вставь путь к фону с розовыми пятнами
            // child: Image.asset('assets/images/bg_tasks.png', fit: BoxFit.cover),
            child: Container(color: Colors.white),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 1. ШАПКА
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildCustomAppBar(),
                ),
                const SizedBox(height: 20),

                // 2. ПЕРЕКЛЮЧАТЕЛЬ ВКЛАДОК (Сделан тоньше, как на макете)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildTabSwitch(),
                ),
                const SizedBox(height: 20),

                // 3. ОСНОВНОЙ КОНТЕНТ
                Expanded(
                  child: SingleChildScrollView(
                    // ОТСТУПЫ СТРАНИЦЫ 16 ПИКСЕЛЕЙ
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // --- ДИНАМИЧЕСКИЙ БАННЕР ---
                        _selectedTab == 0
                            ? _buildRouteBanner()
                            : _buildMissionBanner(),
                        const SizedBox(height: 20),

                        // --- ФИЛЬТРЫ (Квадратные со скруглением) ---
                        _buildFiltersRow(),
                        const SizedBox(height: 20),

                        // --- ДИНАМИЧЕСКИЙ СПИСОК КАРТОЧЕК ---
                        _selectedTab == 0
                            ? _buildRoutesList()
                            : _buildMissionsList(),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // ВИДЖЕТЫ ЭКРАНА
  // ==========================================

  Widget _buildCustomAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.nightlight_round, size: 28),
        const Text(
          "ЗАДАНИЯ",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const Icon(Icons.notifications_none, size: 30),
      ],
    );
  }

  // --- ПЕРЕКЛЮЧАТЕЛЬ ВКЛАДОК ---
  Widget _buildTabSwitch() {
    return Container(
      height: 44, // ИСПРАВЛЕНО: Сделал плашку тоньше (было 50)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          _buildTabItem(text: "Маршруты", index: 0),
          _buildTabItem(text: "Миссии", index: 1),
        ],
      ),
    );
  }

  Widget _buildTabItem({required String text, required int index}) {
    bool isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.pink.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.pink : Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // --- ФИЛЬТРЫ ---
  Widget _buildFiltersRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterIcon(Icons.search),
          const SizedBox(width: 8),
          _buildFilterIcon(Icons.filter_list),
          const SizedBox(width: 8),
          _buildFilterChip("Рядом", isActive: _selectedTab == 1),
          const SizedBox(width: 8),
          _buildFilterChip("До 30 мин", isActive: false),
        ],
      ),
    );
  }

  // ИСПРАВЛЕНО: Сделал иконки квадратами со скруглением (как на макете)
  Widget _buildFilterIcon(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Скругленные квадраты
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 20),
    );
  }

  Widget _buildFilterChip(String text, {bool isActive = false}) {
    return Container(
      height: 42,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? Colors.pink.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12), // Под размер иконок
        border: Border.all(
          color: isActive ? Colors.pink : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: isActive ? Colors.pink : Colors.black,
        ),
      ),
    );
  }

  // --- БАННЕР 1: МАРШРУТЫ ---
  Widget _buildRouteBanner() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Случайные метки",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Ищите случайные метки на карте города и получайте награды за каждую пройденную точку!",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Искать метки",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ИСПРАВЛЕНО: Увеличена высота и добавлен Stack для 2 картинок (фон + карта)
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 120, // Увеличил высоту фото
              child: Stack(
                children: [
                  // Слой 1: Фон картинки
                  Positioned.fill(
                    child: Container(
                      color: Colors.pink.shade50,
                    ), // Заглушка фона
                    // child: Image.asset('путь_к_фону_картинки', fit: BoxFit.cover),
                  ),
                  // Слой 2: Сама карта/маршрут
                  Positioned.fill(
                    child: Container(
                      color: Colors.grey.withValues(alpha: 0.3),
                    ), // Заглушка карты
                    // child: Image.asset('путь_к_карте', fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- БАННЕР 2: МИССИИ ---
  Widget _buildMissionBanner() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            left: 16,
            top: 16,
            bottom: 16,
            right: 120,
          ), // Место под кота
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Хотите потратить баллы?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              // ИСПРАВЛЕНО: line-height (height: 1.1) сделан меньше
              const Text(
                "Обменивайте накопленные\nбаллы на бонусы, скидки или\nподарки.",
                style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.1),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5397F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Потратить баллы",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        // КОТ СПРАВА
        Positioned(
          right: 0,
          bottom: 0,
          top: 0,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 120,
              height: 100,
              color: Colors.grey.shade300,
            ), // Заменишь на Image.asset кота
          ),
        ),
      ],
    );
  }

  // --- СПИСОК 1: МАРШРУТЫ ---
  Widget _buildRoutesList() {
    return Column(
      children: [
        _buildRouteCard(
          title: "Стальной характер города",
          diffColor: Colors.orange,
          diffText: "Средний",
          badge: "БАРДАК",
        ),
        const SizedBox(height: 16),
        _buildRouteCard(
          title: "По следам великого писателя",
          diffColor: Colors.green,
          diffText: "Легкий",
          badge: null,
        ),
      ],
    );
  }

  // --- СПИСОК 2: МИССИИ ---
  Widget _buildMissionsList() {
    return Column(
      children: [
        _buildMissionCard(
          title: "Купите кофе в Surf Coffee",
          subtitle:
              "Купите любое кофе в Surf coffee и получите за это вознаграждение",
          badgeLeft: "SURF COFFEE",
          badgeRight: "+70 Б.",
        ),
        const SizedBox(height: 16),
        _buildMissionCard(
          title: "Купите любое блюдо от 300руб.",
          subtitle:
              "Купите любое блюдо в “Бардак” и получите за это вознаграждение",
          badgeLeft: "БАРДАК",
          badgeRight: "+90 Б.",
        ),
      ],
    );
  }

  // --- КАРТОЧКА МАРШРУТА ---
  Widget _buildRouteCard({
    required String title,
    required Color diffColor,
    required String diffText,
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 110,
                  height: 130,
                  color: Colors.grey.shade400,
                ),
              ),
              if (badge != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: diffColor),
                    const SizedBox(width: 4),
                    Text(
                      diffText,
                      style: TextStyle(
                        color: diffColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "+100 XP",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Описание маршрута кратко...",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Начать маршрут",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- КАРТОЧКА МИССИИ ---
  Widget _buildMissionCard({
    required String title,
    required String subtitle,
    required String badgeLeft,
    required String badgeRight,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 140,
                  height: 130,
                  color: Colors.grey.shade400,
                ),
              ),
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
                  child: Text(
                    badgeLeft,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badgeRight,
                    style: const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w900,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5397F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Посмотреть на карте",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- НИЖНЕЕ МЕНЮ ---
  Widget _buildBottomNav() {
    return Container(
      height: 85,
      padding: const EdgeInsets.only(bottom: 15, top: 10),
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
          _navItem(Icons.home_outlined, "Главная"),
          _navItem(Icons.assignment, "Задания", isActive: true),
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
