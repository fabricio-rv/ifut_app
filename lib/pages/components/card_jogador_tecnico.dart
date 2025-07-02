import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final IconData? icon;
  final double fontSize;
  final EdgeInsetsGeometry? padding;
  final TextStyle? customTextStyle; // NOVO PARÂMETRO

  const CustomBadge({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    this.icon,
    this.fontSize = 22,
    this.padding,
    this.customTextStyle, // NOVO PARÂMETRO
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: fontSize + 2),
            SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

Color corBronze() => Color(0xFFCC8844);
Color corPrata() => Color(0xFFC0C0C0);
Color corOuro() => Color(0xFFFFD700);
Color corDiamante() => Color(0xFF7DF9FF);
Color corAzulBadge() => Color(0xFF0D213A);
Color corAzulClaro() => Color(0xFF36C2FF);
Color corVerdeNeon() => Color(0xFF00FF00);

Color corOver(int over) {
  if (over >= 100) return Color(0xFF6D4C41);
  if (over >= 90) return corDiamante();
  if (over >= 80) return corOuro();
  if (over >= 70) return corPrata();
  if (over >= 60) return corBronze();
  if (over >= 50) return Colors.red;
  return Colors.black;
}

class JogadorTecnicoCard extends StatelessWidget {
  final String nome;
  final String apelido;
  final String fotoUrl;
  final String nacionalidade;
  final int overall;
  final int nivel;
  final String posicaoPrincipal; // Ou 'TÉC'
  final List<String> posicoesSecundarias;
  final String peDominante;
  final int altura;
  final int peso;
  final List<String> niveis;
  final List<String> badges;
  final String? escudoClube;
  final String? tipoPerfil; // 'Técnico' ou 'Jogador'

  // Técnico (opcionais)
  final List<String> estilosTaticos; // MULTI badge
  final List<String> niveisQueTreina; // MULTI badge
  final String experiencia;
  final String disponibilidade;

  const JogadorTecnicoCard({
    super.key,
    required this.nome,
    required this.apelido,
    required this.fotoUrl,
    required this.nacionalidade,
    this.overall = 50,
    this.nivel = 1,
    required this.posicaoPrincipal,
    this.posicoesSecundarias = const [],
    this.peDominante = '',
    this.altura = 0,
    this.peso = 0,
    this.niveis = const [],
    this.badges = const [],
    this.escudoClube,
    this.tipoPerfil = 'Jogador',
    required this.estilosTaticos,
    required this.niveisQueTreina,
    required this.experiencia,
    required this.disponibilidade,
  });

  @override
  Widget build(BuildContext context) {
    final verdeNeon = corVerdeNeon();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isPortrait = height > width;
    final double avatarSize = width * 0.60; // responsivo
    Widget tecnicoBadge(String label, String value, double width) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: width * 0.012),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: width * 0.018,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: corVerdeNeon(), width: 1.4),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: width * 0.038,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.045,
              ),
            ),
          ],
        ),
      );
    }

    // POSIÇÕES SECUNDÁRIAS BADGES
    final posicoesSecundariasWidgets = posicoesSecundarias
        .map(
          (p) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: CustomBadge(
              text: p,
              bgColor: corPrata(),
              textColor: Colors.black,
              fontSize: width * 0.040,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.050,
                vertical: width * 0.025,
              ),
              // Troque o style do texto para poppins
              customTextStyle: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.040,
              ),
            ),
          ),
        )
        .toList();

    // Físicos (pe, altura, peso)
    final fisicoWidgets = [
      if (peDominante.isNotEmpty)
        CustomBadge(
          text: peDominante,
          bgColor: verdeNeon,
          textColor: Colors.black,
          fontSize: width * 0.040,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.035,
            vertical: width * 0.025,
          ),
          customTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.040,
          ),
        ),
      if (altura > 0)
        CustomBadge(
          text: '$altura cm',
          bgColor: verdeNeon,
          textColor: Colors.black,
          fontSize: width * 0.040,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.035,
            vertical: width * 0.025,
          ),
          customTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.040,
          ),
        ),
      if (peso > 0)
        CustomBadge(
          text: '$peso kg',
          bgColor: verdeNeon,
          textColor: Colors.black,
          fontSize: width * 0.040,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.035,
            vertical: width * 0.025,
          ),
          customTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.040,
          ),
        ),
    ];

    // Níveis - bronze, prata, ouro
    List<String> bronzeNiveis = ['pereba', 'resenha', 'casual'];
    List<String> prataNiveis = ['intermediario', 'avançado', 'competidor'];
    List<String> ouroNiveis = ['semi-amador', 'amador', 'ex-profissional'];
    List<Widget> niveisWidgets = niveis.map((n) {
      final lower = n.toLowerCase();
      Color bg;
      if (bronzeNiveis.contains(lower)) {
        bg = corBronze();
      } else if (prataNiveis.contains(lower))
        bg = corPrata();
      else
        bg = corOuro();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: CustomBadge(
          text: n[0].toUpperCase() + n.substring(1),
          bgColor: bg,
          textColor: Colors.black,
          fontSize: width * 0.030,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.023,
            vertical: width * 0.032,
          ),
          customTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.030,
          ),
        ),
      );
    }).toList();

    // BADGES DE CONQUISTA
    final conquistasColors = [
      corBronze(),
      corPrata(),
      corOuro(),
      corDiamante(),
    ];
    final conquistasWidgets = List.generate(4, (i) {
      return Expanded(
        child: Container(
          height: width * 0.15,
          margin: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: 2),
          decoration: BoxDecoration(
            color: conquistasColors[i],
            borderRadius: BorderRadius.circular(width * 0.04),
            border: Border.all(color: verdeNeon, width: 3),
          ),
          child: Center(
            child: Text('🏆', style: TextStyle(fontSize: width * 0.09)),
          ),
        ),
      );
    });

    // Agora, o layout responsivo:
    return AspectRatio(
      aspectRatio: 3 / 4.7,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(width * 0.08),
          border: Border.all(color: verdeNeon, width: width * 0.011),
        ),
        padding: EdgeInsets.all(width * 0.045),
        child: Stack(
          children: [
            // OVERALL - topo esquerdo
            Positioned(
              top: width * 0.00,
              left: width * 0.00,
              child: Text(
                overall.toString(),
                style: TextStyle(
                  color: corOver(overall),
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.12,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            // LEVEL - topo direito
            Positioned(
              top: width * 0.02,
              right: width * 0.00,
              child: Text(
                'Lvl $nivel',
                style: TextStyle(
                  color: corAzulClaro(),
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.06,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // POSIÇÃO PRINCIPAL ou TÉC (se técnico)
            Positioned(
              top: width * 0.15,
              left: width * 0.00,
              child: Text(
                tipoPerfil == 'Técnico' ? 'TÉC' : posicaoPrincipal,
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.062,
                ),
              ),
            ),

            // Bandeira nacionalidade
            Positioned(
              top: width * 0.25,
              left: width * 0.00,
              child: Image.asset(
                'assets/bandeiras/${nacionalidade.toLowerCase()}.png',
                width: width * 0.14,
                height: width * 0.11,
                errorBuilder: (c, e, s) =>
                    SizedBox(width: width * 0.12, height: width * 0.08),
              ),
            ),

            // Escudo
            Positioned(
              top: width * 0.36,
              right: width * 0.64,
              child: escudoClube == null || escudoClube!.isEmpty
                  ? Image.asset(
                      'assets/escudo_sem_clube.png',
                      width: width * 0.18,
                      height: width * 0.18,
                      fit: BoxFit.contain,
                    )
                  : escudoClube!.startsWith('http')
                  ? Image.network(escudoClube!, fit: BoxFit.contain)
                  : Image.asset(escudoClube!, fit: BoxFit.contain),
            ),

            // AVATAR CENTRALIZADO, GRANDE
            Positioned(
              top: width * 0.00,
              left: 0,
              right: 0,
              child: Center(
                child: ClipOval(
                  child: Container(
                    color: Colors.transparent,
                    width: avatarSize,
                    height: avatarSize,
                    child: Image(
                      image: fotoUrl.isNotEmpty
                          ? NetworkImage(fotoUrl)
                          : AssetImage('assets/default_avatar.png')
                                as ImageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // APELIDO CENTRALIZADO, LOGO ABAIXO AVATAR
            Positioned(
              top: width * 0.57,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  apelido.isNotEmpty ? apelido : '--',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.10,
                    color: verdeNeon,
                    letterSpacing: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // BADGES SECUNDÁRIAS | FÍSICO | NÍVEIS (VERTICAL, responsivo)
            Positioned(
              top: avatarSize + width * 0.12,
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // COLUNA ESQUERDA
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: tipoPerfil == 'Técnico'
                          ? [
                              if ((experiencia ?? '').isNotEmpty)
                                tecnicoBadge('Exp.', experiencia, width),
                              if ((disponibilidade ?? '').isNotEmpty)
                                tecnicoBadge('Disp.', disponibilidade, width),
                            ]
                          : posicoesSecundariasWidgets
                                .map(
                                  (w) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: width * 0.01,
                                    ),
                                    child: w,
                                  ),
                                )
                                .toList(),
                    ),
                  ),

                  // COLUNA MEIO
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: tipoPerfil == 'Técnico'
                          ? (estilosTaticos.isNotEmpty
                                ? estilosTaticos
                                      .map(
                                        (e) => Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: width * 0.01,
                                          ),
                                        ),
                                      )
                                      .toList()
                                : [SizedBox()])
                          : fisicoWidgets
                                .map(
                                  (w) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: width * 0.01,
                                    ),
                                    child: w,
                                  ),
                                )
                                .toList(),
                    ),
                  ),
                  // COLUNA DIREITA
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: tipoPerfil == 'Técnico'
                          ? (niveisQueTreina.isNotEmpty
                                ? niveisQueTreina
                                      .map(
                                        (n) => Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: width * 0.01,
                                          ),
                                        ),
                                      )
                                      .toList()
                                : [SizedBox()])
                          : niveisWidgets
                                .map(
                                  (w) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: width * 0.01,
                                    ),
                                    child: w,
                                  ),
                                )
                                .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
