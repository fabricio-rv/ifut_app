import 'package:flutter/material.dart';

class BotaoVoltar extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isMobile;

  const BotaoVoltar({Key? key, required this.onPressed, this.isMobile = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back, color: Color(0xFF00FF00)),
        label: Text(
          "VOLTAR",
          style: TextStyle(
            color: const Color(0xFF00FF00),
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 22 : 22,
            letterSpacing: 1.1,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF00FF00), width: 2.2),
          foregroundColor: const Color(0xFF00FF00),
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
