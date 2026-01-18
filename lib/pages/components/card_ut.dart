import 'package:flutter/material.dart';
import 'dart:math'; // Necessário para Transform.rotate

/// CardPosicaoUT - Card de Posição no estilo Ultimate Team, responsivo e animado.
/// Utiliza as mesmas cores e efeitos de brilho/sombra do JogadorTecnicoCard.
class CardPosicaoUT extends StatefulWidget {
  final String emoji;
  final String nome;
  final bool destaque; // Para posição principal (ex: ouro)
  final bool secundaria; // Para posições secundárias (ex: prata)
  final bool
  selecionado; // Para uma posição clicada/selecionada (ex: azul neon)
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
    this.selecionado = false,
  });

  @override
  State<CardPosicaoUT> createState() => _CardPosicaoUTState();
}

class _CardPosicaoUTState extends State<CardPosicaoUT>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1550),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cores padrões UT, alinhadas com as cores do JogadorTecnicoCard
    const Color neonGreen = Color(0xFF39FF14);
    const Color neonBlue = Color(0xFF03E1FF);
    const Color gold = Color(0xFFFED700);
    const Color silver = Color(0xFFD6D6D6);

    // Define borda, sombra e cor de fundo por estado
    Color borderColor = neonGreen;
    double borderWidth = 2.2;
    Color shadowColor =
        neonGreen; // Default para não destacado/secundário/selecionado

    if (widget.destaque) {
      borderColor = gold;
      borderWidth = 4.2;
      shadowColor = gold; // Sombra dourada para destaque
    } else if (widget.secundaria) {
      borderColor = silver;
      borderWidth = 3.2;
      shadowColor = silver; // Sombra prateada para secundária
    } else if (widget.selecionado) {
      borderColor = neonBlue;
      borderWidth = 3.0;
      shadowColor = neonBlue; // Sombra azul para selecionado
    }

    // Brilho animado UT (SweepGradient)
    Widget animatedGlow = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double anim = _controller.value;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow:
                widget.destaque || widget.secundaria || widget.selecionado
                ? [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.23 + anim * 0.28),
                      blurRadius: 23 + anim * 17,
                      spreadRadius: 2 + anim * 3,
                    ),
                  ]
                : [],
            gradient: widget.destaque
                ? SweepGradient(
                    colors: [
                      gold.withOpacity(0.16 + anim * 0.30),
                      gold.withOpacity(0.05),
                      gold.withOpacity(0.16 + anim * 0.30),
                    ],
                  )
                : widget.secundaria
                ? SweepGradient(
                    colors: [
                      silver.withOpacity(0.12 + anim * 0.26),
                      silver.withOpacity(0.06),
                      silver.withOpacity(0.12 + anim * 0.26),
                    ],
                  )
                : widget.selecionado
                ? SweepGradient(
                    colors: [
                      neonBlue.withOpacity(0.12 + anim * 0.25),
                      neonBlue.withOpacity(0.05),
                      neonBlue.withOpacity(0.12 + anim * 0.25),
                    ],
                  )
                : null,
          ),
        );
      },
    );

    // Sparkle animado (estrelas)
    Widget sparkle = Positioned(
      top: 7,
      right: 10,
      child: widget.destaque
          ? TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.7, end: 1.13),
              duration: const Duration(milliseconds: 1250),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Icon(
                    Icons.star,
                    color: gold.withOpacity(0.85),
                    size: 19,
                    shadows: [
                      Shadow(blurRadius: 8, color: gold.withOpacity(0.55)),
                    ],
                  ),
                );
              },
            )
          : widget.secundaria
          ? TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.7, end: 1.06),
              duration: const Duration(milliseconds: 990),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Icon(
                    Icons.star,
                    color: silver.withOpacity(0.58),
                    size: 14,
                  ),
                );
              },
            )
          : widget.selecionado
          ? TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.85, end: 1.05),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Icon(
                    Icons.star,
                    color: neonBlue.withOpacity(0.41),
                    size: 14,
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );

    // Tilt dinâmico (rotação leve)
    double tilt = 0;
    if (widget.destaque) tilt = 0.04;
    if (widget.secundaria) tilt = -0.03;
    if (widget.selecionado) tilt = 0.06;

    return AnimatedScale(
      scale: widget.destaque
          ? 1.14
          : widget.secundaria
          ? 1.08
          : widget.selecionado
          ? 1.11
          : 1.0,
      duration: const Duration(milliseconds: 185),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: tilt),
        duration: const Duration(milliseconds: 200),
        builder: (context, value, child) {
          return Transform.rotate(
            angle: value,
            child: Material(
              color: Colors.transparent,
              elevation: widget.destaque
                  ? 22
                  : widget.secundaria
                  ? 14
                  : widget.selecionado
                  ? 11
                  : 7,
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  Container(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: borderColor,
                        width: borderWidth,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor.withOpacity(0.31),
                          blurRadius: widget.destaque
                              ? 24
                              : widget.secundaria
                              ? 15
                              : widget.selecionado
                              ? 10
                              : 6,
                          spreadRadius: widget.destaque
                              ? 6
                              : widget.secundaria
                              ? 3
                              : widget.selecionado
                              ? 2
                              : 1,
                          offset: Offset(0, widget.destaque ? 10 : 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center, // Centraliza tudo!
                      children: [
                        if (widget.destaque ||
                            widget.secundaria ||
                            widget.selecionado)
                          Positioned.fill(child: animatedGlow),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Garante centro horizontal
                            children: [
                              Text(
                                widget.emoji,
                                style: TextStyle(
                                  fontSize: widget.emojiSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 13,
                                      color: neonBlue.withOpacity(0.62),
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: widget.height * 0.10),
                              Text(
                                widget.nome,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: widget.fontSize,
                                  color:
                                      borderColor, // Cor da borda para o texto
                                  letterSpacing: -0.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        sparkle,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
