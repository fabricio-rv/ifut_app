import 'package:flutter/material.dart';

class TituloSecao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final bool mobile;

  const TituloSecao(this.texto, this.icone, this.mobile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Icon(icone, color: const Color(0xFF00FF00), size: 28),
          const SizedBox(width: 9),
          Text(
            texto,
            style: TextStyle(
              color: const Color(0xFF00FF00),
              fontSize: mobile ? 21 : 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
