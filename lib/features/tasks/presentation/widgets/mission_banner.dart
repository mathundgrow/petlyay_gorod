import 'package:flutter/material.dart';

class MissionBanner extends StatelessWidget {
  const MissionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Белая плашка с текстом
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 120),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Хотите потратить баллы?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const Text("Обменивайте накопленные\nбаллы на бонусы, скидки или\nподарки.", style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.2)),
              const SizedBox(height: 12),
              Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: const Color(0xFFE5397F), borderRadius: BorderRadius.circular(20)), child: const Text("Потратить баллы", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
            ],
          ),
        ),
        // Спящий кот
        Positioned(
          right: 0, bottom: 0, top: 0,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(width: 110, height: 100, color: Colors.grey.shade300), // Заменишь на Image.asset
          ),
        ),
      ],
    );
  }
}