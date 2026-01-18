// widgets/notificacoes_widget.dart
import 'package:flutter/material.dart';

class NotificacoesWidget extends StatelessWidget {
  // Lista fixa dos tipos de notificações disponíveis
  static const List<String> tiposNotificacoes = [
    "Jogos próximos",
    "Promoções/sorteios",
    "Atualizações do app",
  ];

  final Map<String, bool> notificacoes;
  final void Function(String, bool) onChanged;

  const NotificacoesWidget({
    super.key,
    required this.notificacoes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tiposNotificacoes.map((tipo) {
        return CheckboxListTile(
          title: Text(
            tipo,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          activeColor: const Color(0xFF00FF00),
          checkColor: Colors.black,
          value: notificacoes[tipo] ?? false, // pega do map atual
          onChanged: (val) => onChanged(tipo, val ?? false),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        );
      }).toList(),
    );
  }
}
