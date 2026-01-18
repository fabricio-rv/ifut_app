import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

/// CardPosicaoUT com centralização perfeita
class CardPosicaoUT extends StatelessWidget {
  final String emoji;
  final String nome;
  final bool destaque;
  final bool secundaria;

  const CardPosicaoUT({
    super.key,
    required this.emoji,
    required this.nome,
    this.destaque = false,
    this.secundaria = false,
  });

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final double cardWidth = largura < 350 ? 68 : 82;
    final double cardHeight = largura < 350 ? 85 : 108;
    final double fontSize = largura < 350 ? 14 : 18;
    final double emojiSize = largura < 350 ? 29 : 39;
    const Color neonGreen = Color(0xFF39FF14);

    return AnimatedScale(
      scale: destaque ? 1.12 : 1.0,
      duration: const Duration(milliseconds: 190),
      child: Material(
        color: Colors.transparent,
        elevation: destaque ? 16 : 8,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 160),
          opacity: secundaria ? 0.75 : 1,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: destaque ? Colors.white : neonGreen,
                width: destaque ? 3.2 : 2.2,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: neonGreen.withOpacity(0.23),
                  blurRadius: destaque ? 18 : 9,
                  spreadRadius: destaque ? 4 : 1,
                  offset: Offset(0, destaque ? 8 : 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    emoji,
                    style: TextStyle(
                      fontSize: emojiSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: neonGreen.withOpacity(0.9),
                          offset: const Offset(0, 0),
                        ),
                        Shadow(
                          blurRadius: 17,
                          color: Colors.white.withOpacity(0.16),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    nome,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: fontSize,
                      color: neonGreen,
                      letterSpacing: -0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
