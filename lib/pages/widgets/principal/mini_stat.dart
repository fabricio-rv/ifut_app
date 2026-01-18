import 'package:flutter/material.dart';

class MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;
  const MiniStat({required this.icon, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.greenAccent, size: 16),
        const SizedBox(width: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
