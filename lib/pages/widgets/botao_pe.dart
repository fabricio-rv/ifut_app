import 'package:flutter/material.dart';

class BotaoPe extends StatelessWidget {
  final String texto;
  final IconData icone;
  final bool selecionado;
  final VoidCallback onPressed;

  const BotaoPe({
    super.key,
    required this.texto,
    required this.icone,
    required this.selecionado,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: selecionado ? Colors.black : const Color(0xFF00FF00),
        backgroundColor: selecionado ? const Color(0xFF00FF00) : Colors.black,
        side: BorderSide(
          color: selecionado ? const Color(0xFF00FF00) : Colors.green,
          width: 2.2,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        padding: const EdgeInsets.symmetric(vertical: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      ),
      icon: Icon(icone, size: 27),
      label: Text(texto, textAlign: TextAlign.center),
      onPressed: onPressed,
    );
  }
}
