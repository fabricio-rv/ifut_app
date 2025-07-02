import 'package:flutter/material.dart';
// Importe o arquivo correto do CardPosicaoUT
import 'card_posicao_ut.dart'; // ou card_posicao_ut.dart

class BancoReservasFUT7 extends StatelessWidget {
  final void Function(int idx)? onSelect;
  final int? selecionado;

  const BancoReservasFUT7({super.key, this.onSelect, this.selecionado});

  @override
  Widget build(BuildContext context) {
    final reservas = [
      {'emoji': '🧙🏽‍♂️', 'nome': 'Técnico'},
      {'emoji': '💺', 'nome': 'SUB 1'},
      {'emoji': '💺', 'nome': 'SUB 2'},
      {'emoji': '💺', 'nome': 'SUB 3'},
      {'emoji': '💺', 'nome': 'SUB 4'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(reservas.length, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: GestureDetector(
                onTap: onSelect == null ? null : () => onSelect!(i),
                child: CardPosicaoUT(
                  emoji: reservas[i]['emoji']!,
                  nome: reservas[i]['nome']!,
                  destaque: selecionado == i,
                  secundaria: false,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
