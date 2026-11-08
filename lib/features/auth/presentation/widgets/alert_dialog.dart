import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Показ окна
// ─────────────────────────────────────────────────────────────────────────────
// showGeneralDialog нужен, чтобы получить прозрачный барьер и полностью
// управлять фоном (блюром). Обычный showDialog так не умеет.
Future<void> showPinkAlert(
  BuildContext context, {
  required String message,
  String buttonText = 'Понятно',
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent, // фон рисуем сами, вместе с блюром
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (_, __, ___) =>
        PinkAlertDialog(message: message, buttonText: buttonText),
    transitionBuilder: (context, animation, _, child) {
      final scale = Tween<double>(begin: 0.9, end: 1).animate(
        CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut),
      );
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: ScaleTransition(scale: scale, child: child),
      );
    },
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Само окно
// ─────────────────────────────────────────────────────────────────────────────
class PinkAlertDialog extends StatelessWidget {
  const PinkAlertDialog({
    super.key,
    required this.message,
    this.buttonText = 'Понятно',
  });

  final String message;
  final String buttonText;

  static const Color _pink = Color(0xFFE2408B);

  @override
  Widget build(BuildContext context) {
    // ClipRect обязателен: иначе размытие «вылезает» за границы виджета.
    return Material(
      type: MaterialType.transparency,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7,
            sigmaY: 7,
            tileMode: TileMode.mirror,
          ),
          // Лёгкая «дымка» поверх блюра, чтобы фон не был слишком контрастным.
          child: ColoredBox(
            color: const Color(0x18FFFFFF),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).maybePop(), // тап мимо — закрыть
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GestureDetector(
                    onTap: () {}, // тап по карточке не закрывает окно
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 380),
                      child: _Card(
                        message: message,
                        buttonText: buttonText,
                        onPressed: () => Navigator.of(context).pop(),
                        glow: _pink,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Карточка
// ─────────────────────────────────────────────────────────────────────────────
class _Card extends StatelessWidget {
  const _Card({
    required this.message,
    required this.buttonText,
    required this.onPressed,
    required this.glow,
  });

  final String message;
  final String buttonText;
  final VoidCallback onPressed;
  final Color glow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Размытое «свечение/отражение» под карточкой (как на макете).
        Positioned(
          left: 16,
          right: 16,
          bottom: -22,
          height: 64,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: glow.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFFF3B9D3), width: 1.8),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFCE3EF), Color(0xFFF7CEE2)],
            ),
            
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Иконка + точечный «ореол»
              SizedBox(
                width: 128,
                height: 128,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 66,
                      height: 66,
                      child: CustomPaint(
                        painter: _AlertIconPainter(color: const Color(0xFFD3236B)), // Иконка
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              Text(
                message.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                  color: Color(0xFF101010),
                ),
              ),
              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFEE4E97), Color(0xFFD62A72)],
                    ),
                    
                  ),
                  child: TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                      ),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Иконка: кольцо + треугольник + «!»
// ─────────────────────────────────────────────────────────────────────────────
class _AlertIconPainter extends CustomPainter {
  const _AlertIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2 - 1.5;

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = color;

    // внешнее кольцо
    canvas.drawCircle(c, r, stroke);

    // треугольник
    final tri = Path()
      ..moveTo(c.dx, c.dy - r * 0.62)
      ..lineTo(c.dx + r * 0.58, c.dy + r * 0.42)
      ..lineTo(c.dx - r * 0.58, c.dy + r * 0.42)
      ..close();
    canvas.drawPath(tri, stroke..strokeWidth = 2.2);

    // восклицательный знак
    final bar = Paint()
      ..color = color
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(c.dx, c.dy - r * 0.18),
      Offset(c.dx, c.dy + r * 0.1),
      bar,
    );
    canvas.drawCircle(Offset(c.dx, c.dy + r * 0.29), 1.7, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _AlertIconPainter old) => old.color != color;
}