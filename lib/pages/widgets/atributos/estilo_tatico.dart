// widgets/estilo_tatico.dart
import 'package:flutter/material.dart';

class EstiloTaticoSelector extends StatelessWidget {
  final List<String> selecionados;
  final ValueChanged<List<String>> onChanged;

  const EstiloTaticoSelector({
    Key? key,
    required this.selecionados,
    required this.onChanged,
  }) : super(key: key);

  final List<String> estilosDisponiveis = const [
    'Ofensivo',
    'Defensivo',
    'Equilibrado',
    'Tiki-taka',
    'Contra-ataque',
    'Posse de bola',
    'Pressão alta',
    'Jogo apoiado',
    'Marcaçāo baixa',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 14,
      children: estilosDisponiveis.map((estilo) {
        final isSelected = selecionados.contains(estilo);
        final maxSelected = selecionados.length >= 3 && !isSelected;

        return FilterChip(
          labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          label: Text(
            estilo,
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
                    novaLista.add(estilo);
                  } else {
                    novaLista.remove(estilo);
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
