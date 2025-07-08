import 'package:flutter/material.dart';
import 'dart:math';

String exibeAlaComoSimples(String posicao) {
  if (posicao == 'Ala D' || posicao == 'Ala E') return 'ALA';
  return posicao;
}

// Classe utilitária para posição
class PosicaoCampo {
  final String nome;
  final String emoji;
  const PosicaoCampo(this.nome, this.emoji);
}

// Widget CampinhoFUT7
class CampinhoFUT7 extends StatelessWidget {
  final List<PosicaoCampo> posicoes;
  final String? principal;
  final Set<String> secundarias;
  final void Function(String posicao) onSelect;

  const CampinhoFUT7({
    super.key,
    required this.posicoes,
    required this.principal,
    required this.secundarias,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    // Largura do campo proporcional à tela
    final larguraTela = MediaQuery.of(context).size.width;
    final campoWidth = larguraTela * 0.92;
    final campoHeight = campoWidth * 1.25; // Mantém proporção vertical

    // Cards proporcionais ao campo!
    final cardWidth = campoWidth * 0.24; // era 0.18
    final cardHeight =
        campoHeight * 0.24; // era 0.16// Ajuste se quiser maior/menor
    final fontSize = cardHeight * 0.17;
    final emojiSize = cardHeight * 0.35;

    // Mapeamento das posições para coordenadas no campo
    final positions = {
      "Pivô": Offset(0.50, 0.14),
      "1º Meio": Offset(0.75, 0.61),
      "2º Meio": Offset(0.50, 0.41),
      "Ala E": Offset(0.17, 0.33),
      "Ala D": Offset(0.83, 0.33),
      "Fixo": Offset(0.25, 0.62),
      "Goleiro": Offset(0.50, 0.85),
    };

    return Container(
      width: campoWidth,
      height: campoHeight,
      margin: const EdgeInsets.only(bottom: 5), // aumente aqui!
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _CampoRetangularPainter()),
          ),
          ...positions.entries.map((entry) {
            final nome = entry.key;
            final Offset offset = entry.value;
            final pos = posicoes.firstWhere(
              (p) => p.nome == nome,
              orElse: () => PosicaoCampo(nome, '?'),
            );
            final isPrincipal = principal == nome;
            final isSecundaria = secundarias.contains(nome);

            return Positioned(
              left: offset.dx * campoWidth - cardWidth / 2,
              top: offset.dy * campoHeight - cardHeight / 2,
              child: GestureDetector(
                onTap: () => onSelect(nome),
                child: CardPosicaoUT(
                  emoji: pos.emoji,
                  nome: exibeAlaComoSimples(
                    nome,
                  ).toUpperCase(), // <-- Sempre mostra "ALA"
                  destaque: isPrincipal,
                  secundaria: isSecundaria,
                  width: cardWidth,
                  height: cardHeight,
                  fontSize: fontSize,
                  emojiSize: emojiSize,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// CardPosicaoUT - Card Ultimate Team responsivo e animado para o campinho
class CardPosicaoUT extends StatefulWidget {
  final String emoji;
  final String nome;
  final bool destaque;
  final bool secundaria;
  final bool selecionado;
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
    // Cores padrões UT
    const Color neonGreen = Color(0xFF39FF14);
    const Color neonBlue = Color(0xFF03E1FF);
    const Color gold = Color(0xFFFED700);
    const Color silver = Color(0xFFD6D6D6);

    // Define borda, sombra e cor de fundo por estado
    Color borderColor = neonGreen;
    double borderWidth = 2.2;
    Color shadowColor = neonGreen;
    if (widget.destaque) {
      borderColor = gold;
      borderWidth = 4.2;
      shadowColor = neonBlue;
    } else if (widget.secundaria) {
      borderColor = silver;
      borderWidth = 3.2;
      shadowColor = neonBlue;
    } else if (widget.selecionado) {
      borderColor = neonBlue;
      borderWidth = 3.0;
      shadowColor = neonBlue;
    }

    // Brilho animado UT
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

    // Sparkle animado
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

    // Tilt dinâmico
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
                      alignment: Alignment.center, // <-- Centraliza tudo!
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
                                .center, // <-- Garante centro horizontal
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
                                  color: borderColor,
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

class _CampoRetangularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Fundo escuro
    final fundo = Paint()
      ..color = const Color(0xFF070E10)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(20),
      ),
      fundo,
    );

    // Linhas brancas
    final linhas = Paint()
      ..color = Colors.white.withOpacity(0.78)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Laterais do campo
    final rectCampo = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rectCampo, linhas);

    // Linha do meio (horizontal, pois campo é vertical)
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      linhas,
    );

    // Círculo central
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.14, // círculo central proporcional ao width agora!
      linhas,
    );

    // Ponto do meio
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.02,
      linhas,
    );

    // Grandes áreas (em cima e embaixo)
    double areaAltura = size.height * 0.16;
    double areaLargura = size.width * 0.60;

    // Superior (topo)
    Rect grandeAreaCima = Rect.fromLTWH(
      (size.width - areaLargura) / 2,
      0,
      areaLargura,
      areaAltura,
    );
    canvas.drawRect(grandeAreaCima, linhas);

    // Inferior (base)
    Rect grandeAreaBaixo = Rect.fromLTWH(
      (size.width - areaLargura) / 2,
      size.height - areaAltura,
      areaLargura,
      areaAltura,
    );
    canvas.drawRect(grandeAreaBaixo, linhas);

    // Pequenas áreas
    double pequenaAreaAltura = size.height * 0.06;
    double pequenaAreaLargura = size.width * 0.23;

    // Cima
    Rect pequenaAreaCima = Rect.fromLTWH(
      (size.width - pequenaAreaLargura) / 2,
      0,
      pequenaAreaLargura,
      pequenaAreaAltura,
    );
    canvas.drawRect(pequenaAreaCima, linhas);

    // Baixo
    Rect pequenaAreaBaixo = Rect.fromLTWH(
      (size.width - pequenaAreaLargura) / 2,
      size.height - pequenaAreaAltura,
      pequenaAreaLargura,
      pequenaAreaAltura,
    );
    canvas.drawRect(pequenaAreaBaixo, linhas);

    // Pontos de pênalti
    double distanciaPenalti = size.height * 0.11;
    canvas.drawCircle(
      Offset(size.width / 2, distanciaPenalti),
      size.width * 0.016,
      linhas,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height - distanciaPenalti),
      size.width * 0.016,
      linhas,
    );

    // Curvas de escanteio (cantos superiores/inferiores)
    double raioEscanteio = size.width * 0.07;

    // Superior esquerdo
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, 0), radius: raioEscanteio),
      0,
      pi / 2,
      false,
      linhas,
    );
    // Superior direito
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width, 0), radius: raioEscanteio),
      pi / 2,
      pi / 2,
      false,
      linhas,
    );
    // Inferior esquerdo
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, size.height), radius: raioEscanteio),
      -pi / 2,
      pi / 2,
      false,
      linhas,
    );
    // Inferior direito
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width, size.height),
        radius: raioEscanteio,
      ),
      pi,
      pi / 2,
      false,
      linhas,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
