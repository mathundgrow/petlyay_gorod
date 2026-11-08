import 'package:flutter/material.dart';
import 'package:walk_city/features/auth/presentation/screens/login_screen.dart';

/// Почти чёрный цвет текста (в макете не чистый #000, а чуть мягче).
const Color kInk = Color(0xFF111111);

/// Основной розовый/фуксия из макета.
const Color kPink = Color(0xFFE5327C);

/// Фон экранов — тёплый светло-серый «бумажный».
const Color kSurface = Color(0xFFF4F3F1);

/// Серый для второго уровня текста.
const Color kMuted = Color(0xFF3C3C3C);

/// Крупный заголовок. TextStyle — обычный класс (как структура), описывает
/// шрифт: размер, толщину, межстрочный интервал, цвет.
/// height 1.02 — расстояние между строками чуть меньше кегля, чтобы
/// «ИССЛЕДУЙ / НОВОКУЗНЕЦК» стояли плотно, как в макете.
const TextStyle kTitleStyle = TextStyle(
  fontSize: 36,
  height: 1.02,
  fontWeight: FontWeight.w900,
  letterSpacing: -0.5,
  color: kInk,
);

/// Подзаголовок под заголовком.
const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 14,
  height: 1.35,
  fontWeight: FontWeight.w500,
  color: kMuted,
);

const String kImgFirst = 'assets/images/onboarding/cat_hi.png';
const String kImgThird = 'assets/images/onboarding/cat_final.png';
const String kImgPaws = 'assets/images/onboarding/halftone_bg.png';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key, this.onFinish});

  final VoidCallback? onFinish;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  int _index = 0;

  static const int _pagesCount = 3;

  bool get _isLastPage => _index == _pagesCount - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _index = value),
                children: const [
                  _FirstPage(),
                  _SecondPage(),
                  _ThirdPage(),
                ],
              )),
              _DotsIndicator(count: _pagesCount, index: _index),

              const SizedBox(height: 20),

              Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _PillButton(text: _isLastPage ? 'Начать' : 'Далее',
              onTap: _onNextPressed),
              ),

              const SizedBox(height: 16),
          ],
        )),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_isLastPage) {
      if (widget.onFinish != null) {
        widget.onFinish!();
      }
      else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
      return;
    }
    _pageController.nextPage(duration: const Duration(milliseconds: 320), 
    curve: Curves.easeOutCubic);
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.asset(
          kImgFirst,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          errorBuilder: _imagePlaceholder,
          ),
        ),

        Expanded(
          flex: 42,
          child: Padding(padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _BigTitle(
                  black: 'ИССЛЕДУЙ',
                  pink: 'НОВОКУЗНЕЦК',
                  centered: true,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Проходи задания, открывай новые места\n'
                  'и получай реальные призы',
                  textAlign: TextAlign.center,
                  style: kSubtitleStyle,
                ),
              ],
            ),),
        )
      ],
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            kImgPaws,
            width: 150,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BigTitle(black: 'ГОРОД', pink: 'ЖДЁТ ТЕБЯ'),
              const SizedBox(height: 16),
              const Text(
                'Пройди путь и стань частью городского сообщества',
                style: kSubtitleStyle,
              ),
              const SizedBox(height: 26),

              const _FeatureCard(
                icon: Icons.location_on_outlined,
                title: 'ИССЛЕДУЙ ГОРОД',
                subtitle: 'Открывай новые места\nНовокузнецка',
              ),
              const SizedBox(height: 14),

              const _FeatureCard(
                icon: Icons.calendar_month_outlined,
                title: 'ВЫПОЛНЯЙ ЗАДАНИЯ',
                subtitle: 'Решай загадки, находи подсказки и получай баллы',
              ),
              const SizedBox(height: 14),

              const _FeatureCard(
                icon: Icons.card_giftcard,
                title: 'ПОЛУЧАЙ НАГРАДЫ',
                subtitle: 'Обменивай баллы на скидки, мерч и крутые призы',
              ),

              const Spacer(),
            ],
          )
        )
      ],
    );
  }
}

class _ThirdPage extends StatelessWidget {
  const _ThirdPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _BigTitle(black: 'ГОТОВЫ', pink: 'НАЧАТЬ?'),
          const SizedBox(height: 16),
          const Text(
            'Твой путь по Новокузнецку\nначинается прямо сейчас',
            style: kSubtitleStyle,
          ),
          Expanded(
            child: Image.asset(
              kImgThird,
              fit: BoxFit.contain,
              alignment: AlignmentGeometry.bottomCenter,
              errorBuilder: _imagePlaceholder,
            ),
          ),
        ],
      ),
    );
  }
}

class _BigTitle extends StatelessWidget {
  const _BigTitle({
    required this.black,
    required this.pink,
    this.centered = false,
  });

  final String black;
  final String pink;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: 
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(black, style: kTitleStyle),
        Text(pink, style: kTitleStyle.copyWith(color: kPink)),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget 
{
  const _FeatureCard({
      required this.icon,
      required this.title,
      required this.subtitle
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        border: Border.all(color: kInk, width: 1.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: kPink, size: 36),
          const SizedBox(width: 16),

          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                  color: kInk,
                )),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
            ],
          )),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPink,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: i == index ? 12 : 9,
            height: i == index ? 12 : 9,
            decoration: BoxDecoration(
              color: i == index ? kPink : const Color(0xFFC9C9C9),
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

Widget _imagePlaceholder(BuildContext context, Object error, StackTrace? trace) {
  return Container(
    color: const Color(0xFFC9C9C9),
    alignment: Alignment.center,
    child: const Text(
      '...',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: Color(0xFFC9C9C9)),
    ),
  );
}