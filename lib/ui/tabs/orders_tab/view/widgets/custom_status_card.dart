import 'package:flutter/material.dart';

class CustomStatusCard extends StatelessWidget {
  String title;
  int count;
  Color color;
  IconData icon;
  CustomStatusCard(this.title,this.count,this.color,this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 5,),
              Text(
                '$count',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
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
