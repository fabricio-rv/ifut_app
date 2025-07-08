// widgets/botao_continuar.dart
import 'package:flutter/material.dart';

class BotaoContinuar extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isMobile;

  const BotaoContinuar({
    Key? key,
    required this.onPressed,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.arrow_forward, size: 28, color: Colors.black),
        label: Text(
          'CONTINUAR',
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
