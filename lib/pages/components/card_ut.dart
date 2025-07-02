import 'package:flutter/material.dart';

class CardPosicaoUT extends StatelessWidget {
  final String emoji;
  final String nome;
  final bool destaque;
  final bool secundaria;
  final double width;
  final double height;
  final double fontSize;
  final double emojiSize;

  const CardPosicaoUT({
    super.key,
    required this.emoji,
    required this.nome,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.emojiSize,
    this.destaque = false,
    this.secundaria = false,
  });

  @override
  Widget build(BuildContext context) {
    Color neonGreen = const Color(0xFF39FF14);

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
            width: width,
            height: height,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(height: height * 0.10),
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
    );
  }
}
