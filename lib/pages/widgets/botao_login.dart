// widgets/botao_login.dart

import 'package:flutter/material.dart';

class BotaoLogin extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isMobile;

  const BotaoLogin({Key? key, required this.onPressed, this.isMobile = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.login, size: 32, color: Colors.black),
        label: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 22 : 23,
            letterSpacing: 1.05,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00FF00), // Neon green
          foregroundColor: Colors.black,
          elevation: 10,
          minimumSize: const Size(0, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
