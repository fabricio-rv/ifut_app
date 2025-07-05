import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';

int calcularIdade(DateTime nascimento) {
  final hoje = DateTime.now();
  int idade = hoje.year - nascimento.year;
  if (hoje.month < nascimento.month ||
      (hoje.month == nascimento.month && hoje.day < nascimento.day)) {
    idade--;
  }
  return idade;
}

String _formatarNumeroBonito(num valor, String sufixo) {
  if (valor % 1 == 0) {
    return '${valor.toInt()}$sufixo';
  }
  return '${valor.toStringAsFixed(1)}$sufixo';
}

const Map<String, String> abreviacoesPosicoes = {
  "Goleiro": "GOL",
  "Fixo": "ZAG",
  "Ala D": "ALA",
  "Ala E": "ALA",
  "1º Meio": "VOL",
  "2º Meio": "MEI",
  "Pivô": "ATA",
};

String abreviaPosicao(String p) => abreviacoesPosicoes[p] ?? p.toUpperCase();

const Map<String, String> abreviacoesEstilos = {
  'Ofensivo': 'Ofen.',
  'Defensivo': 'Def.',
  'Equilibrado': 'Equil.',
  'Pressão alta': 'Press.',
  'Jogo apoiado': 'Apoi.',
  'Contra-ataque': 'C.-Atq.',
  'Marcaçāo baixa': 'M. baixa',
  'Tiki-taka': 'T-Taka',
  'Posse de bola': 'Posse',
};

const Map<String, String> abreviacoesNiveisT = {
  'Resenha': 'Rese.',
  'Iniciante': 'Ini.',
  'Casual': 'Casual',
  'Intermediário': 'Médio',
  'Avançado': 'Avan.',
  'Competitivo': 'Comp.',
  'Semi-Amador': 'S-Amad.',
  'Amador': 'Amador',
  'Ex-profissional': 'Ex-Profi',
};

const Map<String, String> abreviacoesNiveisJ = {
  'Pereba': 'Pereba',
  'Resenha': 'Rese.',
  'Casual': 'Casual',
  'Intermediário': 'Médio',
  'Avançado': 'Avan.',
  'Competitivo': 'Comp.',
  'Semi-Amador': 'S-Amad.',
  'Amador': 'Amador',
  'Ex-profissional': 'Ex-Profi',
};

// Mapas de abreviação para experiência e disponibilidade:
const Map<String, String> abreviacoesExperiencia = {
  "Nenhuma": "Nada",
  "Menos de 1 ano": "-1a.",
  "1-3 anos": "1-3a.",
  "3-5 anos": "3-5a.",
  "+5 anos": "+5a.",
  "Só na resenha": "Resenha",
};

const Map<String, String> abreviacoesDisponibilidade = {
  "Muito baixa": "Mt. Baixa",
  "Baixa": "Baixa",
  "Média": "Média",
  "Alta": "Alta",
  "Muito alta": "Mt. Alta",
};

String abreviaPe(String pe) {
  if (pe.toLowerCase() == 'ambidestro') return 'AMBI';
  return pe.toUpperCase();
}

String exibeAlaComoSimples(String posicao) {
  if (posicao == 'Ala D' || posicao == 'Ala E') return 'ALA';
  return posicao;
}

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
            text.toUpperCase(),
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

// Badge menor para estilos táticos e níveis do técnico
Widget tecnicoMiniBadge(
  String text,
  Color borderColor,
  Color textColor,
  double width,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: width * 0.011),
    padding: EdgeInsets.symmetric(
      horizontal: width * 0.048,
      vertical: width * 0.030,
    ),
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(color: borderColor, width: 1.6),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: width * 0.032,
        letterSpacing: 0.25,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
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
  if (over >= 50) return Color(0xFFB71C1C);
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
  final double altura;
  final double peso;
  final List<String> niveis;
  final List<String> badges;
  final String? escudoClube;
  final String? tipoPerfil;
  final bool exibirEscolherFoto;
  final void Function(BuildContext)? onSelecionarFoto;
  final DateTime? dataNascimento; // nova prop
  final String? estado;

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
    this.exibirEscolherFoto = false,
    this.onSelecionarFoto,
    this.dataNascimento,
    this.estado,
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
    final double avatarSize = width * 0.39; // responsivo
    final double avatarWidth = avatarSize; // já definido (width * 0.40)
    final double avatarHeight = avatarSize * 4 / 3;
    Widget tecnicoBadge(String label, String value, double width) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: width * 0.012),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.015,
          vertical: width * 0.036,
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
                fontSize: width * 0.030,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.040,
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
              text: abreviaPosicao(p), // <-- AGORA USA ABREVIAÇÃO!
              bgColor: corPrata(),
              textColor: Colors.black,
              fontSize: width * 0.040,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.045,
                vertical: width * 0.028,
              ),
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
          text: abreviaPe(peDominante), // já faz caixa alta só no PE
          bgColor: verdeNeon,
          textColor: Colors.black,
          fontSize: width * 0.034,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.048,
            vertical: width * 0.032,
          ),
          customTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.040,
            letterSpacing: 0.5,
          ),
        ),
      if (altura > 0)
        CustomBadge(
          text: _formatarNumeroBonito(altura, 'cm'),
          bgColor: verdeNeon,
          textColor: Colors.black,
          fontSize: width * 0.042,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.037,
            vertical: width * 0.026,
          ),
          customTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.040,
            // NÃO usa .toUpperCase() aqui!
          ),
        ),
      if (peso > 0)
        CustomBadge(
          text: _formatarNumeroBonito(peso, 'kg'),
          bgColor: verdeNeon,
          textColor: Colors.black,
          fontSize: width * 0.042,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.037,
            vertical: width * 0.026,
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
    List<String> prataNiveis = ['intermediario', 'avançado', 'competitivo'];
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
          text: abreviacoesNiveisJ[n] ?? (n[0].toUpperCase() + n.substring(1)),
          bgColor: bg,
          textColor: Colors.black,
          fontSize: width * 0.036,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.049,
            vertical: width * 0.030,
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
              top: width * 0.03,
              right: width * 0.00,
              child: Text(
                'NÍV. $nivel',
                style: TextStyle(
                  color: corAzulClaro(),
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.06,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // IDADE - topo direito
            if (dataNascimento != null)
              Positioned(
                top: width * 0.14,
                right: width * 0.01,
                child: Text(
                  '${calcularIdade(dataNascimento!)}yrs',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.062,
                  ),
                ),
              ),

            // Bandeira do ESTADO (DIREITA)
            if ((estado ?? '').isNotEmpty)
              Positioned(
                top: width * 0.25,
                right: width * 0.00,
                child: Image.asset(
                  'assets/estados/${(estado ?? '').toLowerCase()}.png',
                  width: width * 0.14,
                  height: width * 0.11,
                  errorBuilder: (c, e, s) =>
                      SizedBox(width: width * 0.12, height: width * 0.08),
                ),
              ),

            // POSIÇÃO PRINCIPAL ou TÉC (se técnico)
            Positioned(
              top: width * 0.15,
              left: width * 0.01,
              child: Text(
                (tipoPerfil == 'Técnico'
                    ? 'TÉC'
                    : abreviaPosicao(
                        exibeAlaComoSimples(posicaoPrincipal),
                      )), // <-- AGORA USA ABREVIAÇÃO
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: exibirEscolherFoto
                          ? () => onSelecionarFoto?.call(context)
                          : null,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: avatarSize,
                            height: avatarSize * 1.4, // <-- TROQUE AQUI!
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                50,
                              ), // leve arredondado
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: fotoUrl.isNotEmpty
                                ? (fotoUrl.startsWith('/') ||
                                          fotoUrl.startsWith('file:')
                                      ? Image.file(
                                          File(fotoUrl),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          fotoUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Image.asset(
                                                'assets/default_avatar.png',
                                                fit: BoxFit.cover,
                                              ),
                                        ))
                                : Image.asset(
                                    'assets/default_avatar.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          if (exibirEscolherFoto && fotoUrl.isEmpty)
                            Container(
                              width: avatarSize,
                              height: avatarSize * 1.3,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: avatarSize * 0.20,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Clique para escolher',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: avatarSize * 0.08,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
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
                  (apelido.isNotEmpty ? apelido : '--').toUpperCase(),
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
              top: avatarSize + width * 0.33,
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // COLUNA ESQUERDA (Experiência, Disponibilidade)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: tipoPerfil == 'Técnico'
                          ? [
                              if ((experiencia ?? '').isNotEmpty)
                                tecnicoBadge(
                                  'EXP.',
                                  (abreviacoesExperiencia[experiencia] ??
                                          experiencia)
                                      .toUpperCase(),
                                  width,
                                ),
                              if ((disponibilidade ?? '').isNotEmpty)
                                tecnicoBadge(
                                  'DISP.',
                                  (abreviacoesDisponibilidade[disponibilidade] ??
                                          disponibilidade)
                                      .toUpperCase(),
                                  width,
                                ),
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
                  // COLUNA CENTRO (Estilos Táticos)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: tipoPerfil == 'Técnico'
                          ? estilosTaticos
                                .map(
                                  (e) => tecnicoMiniBadge(
                                    (abreviacoesEstilos[e] ?? e)
                                        .toUpperCase(), // badge em maiúsculo
                                    Color(0xFF00FF00),
                                    Color(0xFF00FF00),
                                    width,
                                  ),
                                )
                                .toList()
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
                  // COLUNA DIREITA (Níveis que treina)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: tipoPerfil == 'Técnico'
                          ? niveisQueTreina.map((n) {
                              // Busca cor conforme categoria
                              final lower = n.toLowerCase();
                              Color cor;
                              if ([
                                'resenha',
                                'iniciante',
                                'casual',
                              ].contains(lower)) {
                                cor = corBronze();
                              } else if ([
                                'intermediario',
                                'avançado',
                                'competitivo',
                              ].contains(lower))
                                cor = corPrata();
                              else
                                cor = corOuro();

                              // Aplica abreviação para o badge, já em maiúsculo
                              final String label = (abreviacoesNiveisT[n] ?? n)
                                  .toUpperCase();

                              return tecnicoMiniBadge(
                                label,
                                cor, // borda
                                cor, // texto
                                width,
                              );
                            }).toList()
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
            // ISSO AQUI FICA LOGO ABAIXO, NÃO TIRE:
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Row(children: conquistasWidgets),
            ),
          ],
        ),
      ),
    );
  }
}
