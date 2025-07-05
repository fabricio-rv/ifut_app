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
    final fontSize = cardHeight * 0.18;
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

// Widget CardPosicaoUT responsivo
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
