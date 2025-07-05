// widgets/botao_tutorial.dart
import 'package:flutter/material.dart';

class BotaoTutorial extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isMobile;

  const BotaoTutorial({
    Key? key,
    required this.onPressed,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.school, size: 28, color: Colors.black),
        label: Text(
          'TUTORIAL',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 22 : 24,
            letterSpacing: 1.1,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00FF00), // Verde neon
          elevation: 8,
          minimumSize: const Size(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
