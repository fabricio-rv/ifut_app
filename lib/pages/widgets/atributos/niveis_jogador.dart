// lib/widgets/niveis_jogador_selector.dart
import 'package:flutter/material.dart';

/// Lista padrão dos níveis de jogo para jogador.
const List<String> niveisJogadorPadrao = [
  "Pereba",
  "Resenha",
  "Casual",
  "Intermediário",
  "Avançado",
  "Competitivo",
  "Semi-Amador",
  "Amador",
  "Ex-profissional",
];

/// Widget para selecionar níveis de jogo do jogador.
/// Aceita múltipla seleção até [maxSelecionados].
class NiveisJogadorSelector extends StatelessWidget {
  final List<String> niveis;
  final Set<String> selecionados;
  final void Function(Set<String>) onChanged;
  final int maxSelecionados;

  const NiveisJogadorSelector({
    Key? key,
    this.niveis = niveisJogadorPadrao,
    required this.selecionados,
    required this.onChanged,
    this.maxSelecionados = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 14,
      children: niveis.map((nivel) {
        final isSelected = selecionados.contains(nivel);
        final atMax = selecionados.length >= maxSelecionados && !isSelected;

        return FilterChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              nivel,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
          selected: isSelected,
          selectedColor: Colors.green.withOpacity(0.6),
          checkmarkColor: Colors.black,
          backgroundColor: Colors.black,
          side: const BorderSide(color: Color(0xFF00FF00)),
          onSelected: atMax
              ? null
              : (bool sel) {
                  final novoSet = Set<String>.from(selecionados);
                  if (sel) {
                    novoSet.add(nivel);
                  } else {
                    novoSet.remove(nivel);
                  }
                  onChanged(novoSet);
                },
          disabledColor: Colors.grey.withOpacity(0.3),
        );
      }).toList(),
    );
  }
}
