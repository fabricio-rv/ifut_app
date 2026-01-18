// widgets/niveis_treinador.dart
import 'package:flutter/material.dart';

class NiveisTreinadorSelector extends StatelessWidget {
  final List<String> selecionados;
  final ValueChanged<List<String>> onChanged;

  const NiveisTreinadorSelector({
    Key? key,
    required this.selecionados,
    required this.onChanged,
  }) : super(key: key);

  final List<String> niveisDisponiveis = const [
    'Resenha',
    'Iniciante',
    'Casual',
    'Intermediário',
    'Avançado',
    'Competitivo',
    'Semi-Amador',
    'Amador',
    'Ex-profissional',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 14,
      children: niveisDisponiveis.map((nivel) {
        final isSelected = selecionados.contains(nivel);
        final maxSelected = selecionados.length >= 3 && !isSelected;

        return FilterChip(
          labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          label: Text(
            nivel,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          selected: isSelected,
          onSelected: maxSelected
              ? null
              : (bool selected) {
                  final novaLista = List<String>.from(selecionados);
                  if (selected) {
                    novaLista.add(nivel);
                  } else {
                    novaLista.remove(nivel);
                  }
                  onChanged(novaLista);
                },
          selectedColor: Colors.green.withOpacity(0.6),
          checkmarkColor: Colors.black,
          backgroundColor: Colors.black,
          side: const BorderSide(color: Color(0xFF00FF00)),
          disabledColor: Colors.grey.withOpacity(0.3),
        );
      }).toList(),
    );
  }
}
