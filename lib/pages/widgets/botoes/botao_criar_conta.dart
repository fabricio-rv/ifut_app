import 'package:flutter/material.dart';

class BotaoCriarConta extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isMobile;

  const BotaoCriarConta({
    Key? key,
    required this.onPressed,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00FF00),
          foregroundColor: Colors.black,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 22 : 23,
            letterSpacing: 1.1,
          ),
          minimumSize: const Size(0, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          elevation: 11,
        ),
        icon: const Icon(Icons.person_add_alt_1, size: 32),
        label: const Text('CRIAR CONTA'),
        onPressed: onPressed,
      ),
    );
  }
}
