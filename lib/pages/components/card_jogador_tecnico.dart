import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';

// Funções e cores auxiliares (mantidas como estão)
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
  'Ofensivo': 'Ofen',
  'Defensivo': 'Def',
  'Equilibrado': 'Equil',
  'Pressão alta': 'Press',
  'Jogo apoiado': 'Apoi',
  'Contra-ataque': 'C.-Atq',
  'Marcaçāo baixa': 'M. baixa',
  'Tiki-taka': 'T-Taka',
  'Posse de bola': 'Posse',
};

const Map<String, String> abreviacoesNiveisT = {
  'Resenha': 'Rese',
  'Iniciante': 'Ini',
  'Casual': 'Casual',
  'Intermediário': 'Médio',
  'Avançado': 'Avan',
  'Competitivo': 'Comp',
  'Semi-Amador': 'S-Amad',
  'Amador': 'Amador',
  'Ex-profissional': 'Ex-Profi',
};

const Map<String, String> abreviacoesNiveisJ = {
  'Pereba': 'Pereba',
  'Resenha': 'Rese',
  'Casual': 'Casual',
  'Intermediário': 'Médio',
  'Avançado': 'Avan',
  'Competitivo': 'Comp',
  'Semi-Amador': 'S-Amad',
  'Amador': 'Amador',
  'Ex-profissional': 'Ex-Profi',
};

const Map<String, String> abreviacoesExperiencia = {
  "Nenhuma": "Nada",
  "Menos de 1 ano": "-1a",
  "1-3 anos": "1-3a",
  "3-5 anos": "3-5a",
  "+5 anos": "+5a",
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
  if (pe.toLowerCase() == 'ambidestro') return 'AMBOS';
  return pe.toUpperCase();
}

String exibeAlaComoSimples(String posicao) {
  if (posicao == 'Ala D' || posicao == 'Ala E') return 'ALA';
  return posicao;
}

Color corBronze() => const Color(0xFFCC8844);
Color corPrata() => const Color(0xFFC0C0C0);
Color corOuro() => const Color(0xFFFFD700);
Color corDiamante() => const Color(0xFF7DF9FF);
Color corAzulBadge() => const Color(0xFF0D213A);
Color corAzulClaro() => const Color(0xFF36C2FF);
Color corVerdeNeon() => const Color(0xFF00FF00);

Color corOver(int over) {
  if (over >= 100) return const Color(0xFF6D4C41);
  if (over >= 90) return corDiamante();
  if (over >= 80) return corOuro();
  if (over >= 70) return corPrata();
  if (over >= 60) return corBronze();
  if (over >= 50) return const Color(0xFFB71C1C);
  return Colors.black;
}

// Custom Clipper para o formato do card do FIFA
class _FifaCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double radius = size.width * 0.08; // Raio das bordas arredondadas
    final double topNotchHeight =
        size.height * 0.03; // Altura do "entalhe" superior
    final double topNotchWidthRatio =
        0.2; // Largura do entalhe em relação à largura do card

    // Começa do canto inferior esquerdo arredondado
    path.moveTo(0, size.height - radius);
    path.arcToPoint(
      Offset(radius, size.height),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Linha para o canto inferior direito arredondado
    path.lineTo(size.width - radius, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Linha para o canto superior direito arredondado
    path.lineTo(size.width, radius);
    path.arcToPoint(
      Offset(size.width - radius, 0),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Borda superior com o entalhe
    path.lineTo(size.width / 2 + (size.width * topNotchWidthRatio / 2), 0);
    path.lineTo(size.width / 2, topNotchHeight); // Ponto mais baixo do entalhe
    path.lineTo(size.width / 2 - (size.width * topNotchWidthRatio / 2), 0);
    path.lineTo(radius, 0);

    // Linha para o canto superior esquerdo arredondado
    path.arcToPoint(
      Offset(0, radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true; // Recalcula o clip se o tamanho mudar
}

// Widget auxiliar para exibir um item de estatística no grid do jogador
class _PlayerStatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;
  final double fontSize;
  final IconData? icon; // Novo: ícone opcional

  const _PlayerStatItem({
    required this.label,
    required this.value,
    required this.textColor,
    required this.fontSize,
    this.icon, // Novo: ícone opcional
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize * 0.7, // Rótulo menor
            letterSpacing: 0.5,
          ),
        ),
        Row(
          // Usar Row para ícone e valor
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: textColor,
                size: fontSize * 0.9,
              ), // Tamanho do ícone
              SizedBox(
                width: fontSize * 0.1,
              ), // Espaçamento entre ícone e valor
            ],
            Text(
              value,
              style: GoogleFonts.poppins(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Widget auxiliar para o grid de estatísticas do jogador
class _PlayerStatsGrid extends StatelessWidget {
  final double cardWidth;
  final String peDominante;
  final double altura;
  final double peso;
  final List<String> posicoesSecundarias;
  final List<String> niveis;
  final int jogos;
  final int gols;
  final int assistencias;
  final List<String> modalidades; // Novo

  const _PlayerStatsGrid({
    required this.cardWidth,
    required this.peDominante,
    required this.altura,
    required this.peso,
    required this.posicoesSecundarias,
    required this.niveis,
    this.jogos = 0,
    this.gols = 0,
    this.assistencias = 0,
    required this.modalidades, // Novo
    super.key,
  });

  String _getSecondaryPositionsText() {
    if (posicoesSecundarias.isEmpty) return '--';
    return posicoesSecundarias.map((p) => abreviaPosicao(p)).join(', ');
  }

  String _getNivelText() {
    if (niveis.isEmpty) return '--';
    // Retorna todos os níveis selecionados, abreviados e separados por vírgula
    return niveis.map((n) => abreviacoesNiveisJ[n] ?? n).join(', ');
  }

  String _getModalidadesText() {
    if (modalidades.isEmpty) return '--';
    return modalidades.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white;
    final fontSize =
        cardWidth * 0.06; // Aumentado o tamanho da fonte para as estatísticas

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Alinha o conteúdo ao início
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _PlayerStatItem(
              label: 'PE',
              value: abreviaPe(peDominante),
              textColor: textColor,
              fontSize: fontSize,
            ),
            _PlayerStatItem(
              label: 'ALT',
              value: _formatarNumeroBonito(altura, 'cm'),
              textColor: textColor,
              fontSize: fontSize,
            ),
            _PlayerStatItem(
              label: 'PESO',
              value: _formatarNumeroBonito(peso, 'kg'),
              textColor: textColor,
              fontSize: fontSize,
            ),
          ],
        ),
        SizedBox(height: cardWidth * 0.03), // Espaçamento aumentado
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _PlayerStatItem(
              label: 'JOGOS',
              value: jogos.toString(),
              textColor: textColor,
              fontSize: fontSize,
              icon: Icons.sports_soccer,
            ),
            _PlayerStatItem(
              label: 'GOLS',
              value: gols.toString(),
              textColor: textColor,
              fontSize: fontSize,
              icon: Icons.sports_football,
            ),
            _PlayerStatItem(
              label: 'ASSIST',
              value: assistencias.toString(),
              textColor: textColor,
              fontSize: fontSize,
              icon: Icons.handshake,
            ),
          ],
        ),
        SizedBox(height: cardWidth * 0.03), // Espaçamento aumentado
        Row(
          // Nova linha para POS. SECUNDÁRIAS e SEUS NÍVEIS
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Distribui o espaço
          children: [
            _PlayerStatItem(
              label: 'POS. SECUNDÁRIAS',
              value: _getSecondaryPositionsText(),
              textColor: textColor,
              fontSize: fontSize,
            ),
            _PlayerStatItem(
              label: 'SEUS NÍVEIS',
              value: _getNivelText(),
              textColor: textColor,
              fontSize: fontSize,
            ), // Adicionado SEUS NÍVEIS
          ],
        ),
        SizedBox(height: cardWidth * 0.03), // Espaçamento
        Align(
          // Nova linha para MODALIDADES
          alignment: Alignment.centerLeft,
          child: _PlayerStatItem(
            label: 'MODALIDADES',
            value: _getModalidadesText(),
            textColor: textColor,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}

// Widget para exibir o nível do jogador com barras visuais
class _LevelBars extends StatelessWidget {
  final int nivel;
  final double barWidth;
  final double barHeight;
  final int maxLevel;

  const _LevelBars({
    required this.nivel,
    required this.barWidth,
    this.barHeight = 8.0,
    this.maxLevel = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxLevel, (index) {
        bool isActive = index < nivel;
        return Container(
          width: barWidth / maxLevel - 2, // Distribute width, with small gap
          height: barHeight,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: isActive ? corVerdeNeon() : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

// Badge menor para estilos táticos e níveis do técnico (mantido do seu código, com ajustes de fonte)
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

// Função tecnicoBadge movida para o nível superior
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

// O Widget principal do Card de Jogador/Técnico
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
  final List<String> badges; // Não usado por enquanto, conforme solicitado
  final String? escudoClube;
  final String? tipoPerfil;
  final bool exibirEscolherFoto;
  final void Function(BuildContext)? onSelecionarFoto;
  final DateTime? dataNascimento;
  final String? estado;
  // Técnico (opcionais)
  final List<String> estilosTaticos;
  final List<String> niveisQueTreina;
  final String experiencia;
  final String disponibilidade;
  final int jogos; // Novo
  final int gols; // Novo
  final int assistencias; // Novo
  final List<String> modalidades; // Novo

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
    this.jogos = 0, // Default 0
    this.gols = 0, // Default 0
    this.assistencias = 0, // Default 0
    this.modalidades = const [], // Default vazio
  });

  @override
  Widget build(BuildContext context) {
    final verdeNeon = corVerdeNeon();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final double cardAspectRatio =
        3 / 4.7; // Proporção de aspecto aproximada do card FIFA
    final double cardWidth = width * 0.8; // Ajuste o tamanho geral do card aqui
    final double cardHeight = cardWidth / cardAspectRatio;

    // Dimensões da imagem do jogador dentro do card
    final double playerImageWidth = cardWidth * 0.7;
    final double playerImageHeight =
        playerImageWidth * 1.3; // Proporção similar à silhueta FIFA

    return Center(
      child: AspectRatio(
        aspectRatio: cardAspectRatio,
        child: ClipPath(
          clipper: _FifaCardClipper(),
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              // Gradiente de fundo principal do card: preto/chumbo com verde neon
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[900]!.withOpacity(0.9), // Chumbo escuro
                  Colors.black.withOpacity(0.9), // Preto
                  verdeNeon.withOpacity(0.1), // Leve brilho neon na base
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 8,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Textura de fundo sutil (opcional, pode ser uma imagem ou um Container com gradiente sutil)
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.05, // Transparência da textura
                    child: Image.asset(
                      'assets/background_texture.png', // Adicione uma imagem de textura sutil aqui
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.repeat,
                      errorBuilder: (c, e, s) =>
                          Container(), // Não mostra erro se a imagem não existir
                    ),
                  ),
                ),

                // OVERALL - topo esquerdo
                Positioned(
                  top: cardHeight * 0.02,
                  left: cardWidth * 0.05,
                  child: Text(
                    overall.toString(),
                    style: GoogleFonts.poppins(
                      color: corOver(overall),
                      fontWeight: FontWeight.w900, // Extra bold
                      fontSize: cardWidth * 0.15, // Overall maior
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                // POSIÇÃO PRINCIPAL ou TÉC (se técnico)
                Positioned(
                  top: cardHeight * 0.15,
                  left: cardWidth * 0.06,
                  child: Text(
                    (tipoPerfil == 'Técnico'
                            ? 'TÉC'
                            : abreviaPosicao(
                                exibeAlaComoSimples(posicaoPrincipal),
                              ))
                        .toUpperCase(),
                    style: GoogleFonts.poppins(
                      color:
                          Colors.white, // Branco para contraste no fundo escuro
                      fontWeight: FontWeight.bold,
                      fontSize: cardWidth * 0.07,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                // Bandeira nacionalidade
                Positioned(
                  top: cardHeight * 0.23,
                  left: cardWidth * 0.06,
                  child: Image.asset(
                    'assets/bandeiras/${nacionalidade.toLowerCase()}.png',
                    width: cardWidth * 0.15,
                    height: cardWidth * 0.11,
                    errorBuilder: (c, e, s) => SizedBox(
                      width: cardWidth * 0.12,
                      height: cardWidth * 0.08,
                    ),
                  ),
                ),
                // Escudo
                Positioned(
                  top: cardHeight * 0.32,
                  left: cardWidth * 0.04,
                  child: escudoClube == null || escudoClube!.isEmpty
                      ? Image.asset(
                          'assets/escudo_sem_clube.png',
                          width: cardWidth * 0.18,
                          height: cardWidth * 0.18,
                          fit: BoxFit.contain,
                        )
                      : escudoClube!.startsWith('http')
                      ? Image.network(
                          escudoClube!,
                          fit: BoxFit.contain,
                          width: cardWidth * 0.18,
                          height: cardWidth * 0.18,
                        )
                      : Image.asset(
                          escudoClube!,
                          fit: BoxFit.contain,
                          width: cardWidth * 0.18,
                          height: cardWidth * 0.18,
                        ),
                ),
                // AVATAR CENTRALIZADO, GRANDE
                Positioned(
                  top:
                      cardHeight *
                      0.02, // Ajuste a posição superior para encaixar na metade superior do card
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: exibirEscolherFoto
                          ? () => onSelecionarFoto?.call(context)
                          : null,
                      child: Container(
                        width: playerImageWidth,
                        height: playerImageHeight,
                        decoration: BoxDecoration(
                          color: Colors
                              .transparent, // Fundo transparente para a imagem
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(playerImageWidth * 0.1),
                            topRight: Radius.circular(playerImageWidth * 0.1),
                            bottomLeft: Radius.circular(
                              playerImageWidth * 0.02,
                            ),
                            bottomRight: Radius.circular(
                              playerImageWidth * 0.02,
                            ),
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: fotoUrl.isNotEmpty
                            ? (fotoUrl.startsWith('/') ||
                                      fotoUrl.startsWith('file:')
                                  ? Image.file(File(fotoUrl), fit: BoxFit.cover)
                                  : Image.network(
                                      fotoUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Image.asset(
                                        'assets/default_avatar.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                            : Image.asset(
                                'assets/default_avatar.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                // APELIDO CENTRALIZADO, LOGO ABAIXO AVATAR
                Positioned(
                  top: cardHeight * 0.59, // Posição abaixo da imagem
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      (apelido.isNotEmpty ? apelido : nome)
                          .toUpperCase(), // Usa nome se apelido estiver vazio
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w900, // Extra bold
                        fontSize: cardWidth * 0.09, // Nome maior
                        color: Colors
                            .white, // Branco para contraste no fundo escuro
                        letterSpacing: 1.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // LEVEL - topo direito (agora com barras visuais)
                Positioned(
                  top: cardHeight * 0.04,
                  right: cardWidth * 0.05,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'NÍV. $nivel',
                        style: GoogleFonts.poppins(
                          color: Colors.white, // Branco para contraste
                          fontWeight: FontWeight.bold,
                          fontSize: cardWidth * 0.06,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: cardHeight * 0.005),
                      _LevelBars(
                        nivel: nivel,
                        barWidth: cardWidth * 0.25,
                      ), // Barras de nível
                    ],
                  ),
                ),
                // IDADE - topo direito
                if (dataNascimento != null)
                  Positioned(
                    top: cardHeight * 0.15,
                    right: cardWidth * 0.06,
                    child: Text(
                      '${calcularIdade(dataNascimento!)}yrs',
                      style: GoogleFonts.poppins(
                        color: Colors.white, // Branco para contraste
                        fontWeight: FontWeight.bold,
                        fontSize: cardWidth * 0.062,
                      ),
                    ),
                  ),
                // Bandeira do ESTADO (DIREITA)
                if (estado != null && estado!.isNotEmpty)
                  Positioned(
                    top: cardHeight * 0.22,
                    right: cardWidth * 0.06,
                    child: Image.asset(
                      'assets/estados/${estado!.toLowerCase()}.png',
                      width: cardWidth * 0.14,
                      height: cardWidth * 0.11,
                      errorBuilder: (c, e, s) => SizedBox(
                        width: cardWidth * 0.12,
                        height: cardWidth * 0.08,
                      ),
                    ),
                  ),

                // GRID DE ESTATÍSTICAS / ATRIBUTOS (seção inferior)
                Positioned(
                  top:
                      cardHeight *
                      0.66, // Ajustado para subir mais, logo abaixo do apelido
                  left: 0,
                  right: 0,
                  bottom: 0, // Ocupa o restante do espaço
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7), // Mais escuro no topo
                          corVerdeNeon().withOpacity(0.3), // Mais neon na base
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: cardWidth * 0.05,
                      vertical: cardHeight * 0.02,
                    ),
                    child: tipoPerfil == 'Jogador'
                        ? _PlayerStatsGrid(
                            cardWidth: cardWidth,
                            peDominante: peDominante,
                            altura: altura,
                            peso: peso,
                            posicoesSecundarias: posicoesSecundarias,
                            niveis: niveis,
                            jogos: jogos,
                            gols: gols,
                            assistencias: assistencias,
                            modalidades: modalidades, // Passando as modalidades
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (experiencia.isNotEmpty)
                                tecnicoBadge(
                                  'EXP.',
                                  (abreviacoesExperiencia[experiencia] ??
                                          experiencia)
                                      .toUpperCase(),
                                  width,
                                ),
                              if (disponibilidade.isNotEmpty)
                                tecnicoBadge(
                                  'DISP.',
                                  (abreviacoesDisponibilidade[disponibilidade] ??
                                          disponibilidade)
                                      .toUpperCase(),
                                  width,
                                ),
                              // Estilos Táticos
                              Wrap(
                                spacing: width * 0.015,
                                runSpacing: width * 0.01,
                                children: estilosTaticos
                                    .map(
                                      (e) => tecnicoMiniBadge(
                                        (abreviacoesEstilos[e] ?? e)
                                            .toUpperCase(),
                                        corVerdeNeon(),
                                        corVerdeNeon(),
                                        width,
                                      ),
                                    )
                                    .toList(),
                              ),
                              // Níveis que treina
                              Wrap(
                                spacing: width * 0.015,
                                runSpacing: width * 0.01,
                                children: niveisQueTreina.map((n) {
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
                                  ].contains(lower)) {
                                    cor = corPrata();
                                  } else {
                                    cor = corOuro();
                                  }
                                  final String label =
                                      (abreviacoesNiveisT[n] ?? n)
                                          .toUpperCase();
                                  return tecnicoMiniBadge(
                                    label,
                                    cor,
                                    cor,
                                    width,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                  ),
                ),

                // Ícone FIFA na parte inferior central
                Positioned(
                  bottom:
                      cardHeight *
                      0.01, // Ajuste para ficar dentro da nova seção de degradê
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.sports_soccer,
                      color: corVerdeNeon().withOpacity(0.6),
                      size: cardWidth * 0.08,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
