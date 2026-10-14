import 'package:flutter/material.dart';

class MissionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeLeft;
  final String badgeRight;

  const MissionCard({super.key, required this.title, required this.subtitle, required this.badgeLeft, required this.badgeRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(15), child: Container(width: 140, height: 130, color: Colors.grey.shade400)), // Заглушка фото
              Positioned(top: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: Text(badgeLeft, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10)))),
              Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(8)), child: Text(badgeRight, style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.w900, fontSize: 10)))),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, height: 1.1)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.2)),
                const SizedBox(height: 16),
                Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 10), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFFE5397F), borderRadius: BorderRadius.circular(20)), child: const Text("Посмотреть на карте", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
              ],
            ),
          )
        ],
      ),
    );
  }
}