// HomePage.dart
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 48,
              vertical: isMobile ? 20 : 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HERO SECTION
                isMobile
                    ? Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // CENTRALIZAR
                        children: [
                          Center(
                            child: _HeroTitle(isMobile: isMobile),
                          ), // CENTRO
                          const SizedBox(height: 32),
                          Center(child: _HeroImage(isMobile: isMobile)),
                          const SizedBox(height: 22),
                          Center(
                            child: _HeroButtons(isMobile: isMobile),
                          ), // CENTRO
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _HeroTitle(isMobile: isMobile),
                                const SizedBox(height: 28),
                                _HeroButtons(isMobile: isMobile),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: _HeroImage(isMobile: isMobile),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 24),

                // Features section
                Center(
                  child: Text(
                    'Por que escolher o IFUT?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 28 : 34,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _FeaturesRow(isMobile: isMobile),
                const SizedBox(height: 12),

                // Novo texto destacado (no lugar do "Pronto para começar?")
                Center(
                  child: Text(
                    'Junte-se a centenas de jogadores que já usam o IFUT!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 26 : 32, // Maior
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // Botão MAIOR
                Center(
                  child: _NeonButton(
                    text: 'COMEÇAR AGORA',
                    icon: Icons.rocket_launch_outlined,
                    filled: true,
                    onTap: () {
                      Navigator.pushNamed(context, '/cadastro');
                    },
                    fontSize: isMobile ? 23 : 28, // maior
                    iconSize: isMobile ? 30 : 38, // maior
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

class _HeroTitle extends StatelessWidget {
  final bool isMobile;
  const _HeroTitle({required this.isMobile});
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Organize suas\nPartidas de\n',
            style: TextStyle(
              fontSize: isMobile ? 44 : 62,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.09,
              shadows: [Shadow(color: Colors.black, blurRadius: 2)],
            ),
          ),
          TextSpan(
            text: 'Futebol Society',
            style: TextStyle(
              fontSize: isMobile ? 44 : 62,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF00FF00),
              shadows: [
                Shadow(
                  color: Colors.greenAccent,
                  blurRadius: 26,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ],
      ),
      textAlign: isMobile
          ? TextAlign.center
          : TextAlign.left, // <-- ESSA LINHA!
    );
  }
}

// Botões neon hero, centralizados!
class _HeroButtons extends StatelessWidget {
  final bool isMobile;
  const _HeroButtons({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Centraliza na coluna
      children: [
        Center(
          child: _NeonButton(
            text: 'CADASTRE-SE GRÁTIS',
            icon: Icons.person_add_alt_1,
            filled: true,
            onTap: () {
              Navigator.pushNamed(context, '/cadastro');
            },
            fontSize: isMobile ? 19 : 24,
            iconSize: isMobile ? 22 : 28,
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: _NeonButton(
            text: 'Como Funciona',
            icon: Icons.play_circle_outline,
            filled: false,
            onTap: () {
              Navigator.pushNamed(context, '/tutorial');
            },
            fontSize: isMobile ? 19 : 24,
            iconSize: isMobile ? 22 : 28,
            darkButton: true,
            noShadow: true, // Novo parâmetro
          ),
        ),
      ],
    );
  }
}

// Widget do bloco com os ícones (direita do hero)
class _HeroImage extends StatelessWidget {
  final bool isMobile;
  const _HeroImage({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final double personSize = isMobile ? 120 : 180;
    final double smallIconSize = isMobile ? 38 : 56;
    final double boxSize = isMobile ? 210 : 310;

    return SizedBox(
      width: boxSize,
      height: boxSize * 0.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ícone de pessoas (bem grande)
          Icon(
            Icons.people,
            color: const Color(0xFF00FF00),
            size: personSize,
            shadows: [
              Shadow(color: Colors.green.withOpacity(0.3), blurRadius: 30),
            ],
          ),
          // Localização - topo esquerdo
          Positioned(
            top: 0,
            left: boxSize * 0.14,
            child: Icon(
              Icons.location_on,
              color: const Color(0xFF00FF00),
              size: smallIconSize,
              shadows: [
                Shadow(color: Colors.green.withOpacity(0.3), blurRadius: 18),
              ],
            ),
          ),
          // Calendário - canto inferior esquerdo
          Positioned(
            bottom: 0,
            left: boxSize * 0.15,
            child: Icon(
              Icons.calendar_month,
              color: const Color(0xFF00FF00),
              size: smallIconSize,
            ),
          ),
          // Relógio - canto inferior direito (AGORA MAIS AFASTADO)
          Positioned(
            bottom: boxSize * 0.10,
            right: boxSize * 0.02, // valor menor => mais afastado!
            child: Icon(
              Icons.access_time,
              color: const Color(0xFF00FF00),
              size: smallIconSize,
            ),
          ),
        ],
      ),
    );
  }
}

// Features Row e Cards
class _FeaturesRow extends StatelessWidget {
  final bool isMobile;
  const _FeaturesRow({required this.isMobile});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: isMobile ? 0 : 28,
      runSpacing: isMobile ? 22 : 0,
      alignment: WrapAlignment.center,
      children: [
        _FeatureCard(
          icon: Icons.add_circle_outline,
          title: 'Criar Partidas',
          desc:
              'Organize jogos facilmente definindo local, data, horário e posições disponíveis.',
          isMobile: isMobile,
        ),
        _FeatureCard(
          icon: Icons.search,
          title: 'Encontrar Jogos',
          desc:
              'Busque partidas próximas a você e marque presença na posição que preferir.',
          isMobile: isMobile,
        ),
        _FeatureCard(
          icon: Icons.people_outline,
          title: 'Gerenciar Tudo',
          desc:
              'Controle suas partidas criadas e acompanhe onde você marcou presença.',
          isMobile: isMobile,
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final bool isMobile;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.desc,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : 340, // MAIOR
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 28 : 38, // maior padding
        horizontal: isMobile ? 22 : 36,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.84),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF00FF00), width: 2),
        boxShadow: [
          BoxShadow(color: Colors.green.withOpacity(0.12), blurRadius: 22),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isMobile ? 54 : 70, color: const Color(0xFF00FF00)),
          const SizedBox(height: 18),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: isMobile ? 27 : 34, // IGUAL AO TUTORIAL
              letterSpacing: 0.6,
              shadows: [
                Shadow(
                  color: Colors.greenAccent.withOpacity(0.18),
                  blurRadius: 7,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 11),
          Text(
            desc,
            style: TextStyle(
              color: Colors.white.withOpacity(0.98),
              fontSize: isMobile ? 18.5 : 22, // IGUAL AO TUTORIAL
              height: 1.32,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Atualize o _NeonButton para aceitar o noShadow (opcional)
class _NeonButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  final double? fontSize;
  final double? iconSize;
  final bool darkButton;
  final bool noShadow; // Adicionado!

  const _NeonButton({
    required this.text,
    required this.icon,
    required this.onTap,
    this.filled = false,
    this.fontSize,
    this.iconSize,
    this.darkButton = false,
    this.noShadow = false, // Padrão: falso
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled
          ? const Color(0xFF00FF00)
          : (darkButton ? Colors.black : Colors.transparent),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: filled
                ? null
                : Border.all(color: const Color(0xFF00FF00), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FF00).withOpacity(0.18),
                blurRadius: 18,
                spreadRadius: filled ? 7 : 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: filled ? Colors.black : const Color(0xFF00FF00),
                size: iconSize ?? 28,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: filled ? Colors.black : const Color(0xFF00FF00),
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize ?? 22,
                  letterSpacing: 1.2,
                  shadows: (filled || (!noShadow && !filled))
                      ? [
                          Shadow(
                            color: filled
                                ? const Color(0xFF00FF00).withOpacity(0.16)
                                : Colors.transparent,
                            blurRadius: filled ? 8 : 0,
                          ),
                        ]
                      : [], // Sem sombra se noShadow=true
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
