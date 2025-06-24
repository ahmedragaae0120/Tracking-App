import 'package:flutter/material.dart';

class CustomStatusCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;

  const CustomStatusCard(this.title, this.count, this.color, this.icon,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.02), // أفضل من withValues
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                '$count',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
