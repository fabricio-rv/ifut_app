import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 38,
            vertical: isMobile ? 16 : 44,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // HERO TUTORIAL
              Stack(
                children: [
                  if (!isMobile)
                    Positioned(
                      top: 6,
                      right: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.32),
                              blurRadius: 30,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.sports_soccer,
                          size: 80,
                          color: const Color(0xFF00FF00),
                        ),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: isMobile ? 16 : 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: isMobile ? 44 : 60,
                            color: const Color(0xFF00FF00),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Como Funciona o IFUT',
                            style: TextStyle(
                              fontSize: isMobile ? 32 : 46,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.greenAccent,
                                  blurRadius: 18,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Aprenda a usar nossa plataforma em poucos passos e aproveite ao máximo suas partidas!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.88),
                          fontSize: isMobile ? 17 : 25,
                        ),
                      ),
                      SizedBox(height: isMobile ? 20 : 36),
                    ],
                  ),
                ],
              ),
              // ETAPAS GRANDES
              _TutorialSteps(isMobile: isMobile),
              SizedBox(height: 48),
              // BOTÃO FINAL GRANDÃO
              _NeonButton(
                text: 'Voltar para Início',
                icon: Icons.arrow_back_rounded,
                filled: true,
                fontSize: isMobile ? 22 : 28,
                iconSize: isMobile ? 25 : 32,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// PASSOS DO TUTORIAL — Tudo grande, modelo grid
class _TutorialSteps extends StatelessWidget {
  final bool isMobile;
  const _TutorialSteps({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    // Dados dos passos
    final steps = [
      (
        icon: Icons.person_add_alt_1,
        title: 'Cadastre-se',
        desc:
            'Crie sua conta gratuitamente informando seus dados básicos e suas posições preferidas no campo.',
      ),
      (
        icon: Icons.search,
        title: 'Encontre Partidas',
        desc:
            'Explore nossa lista de partidas abertas e solicite participação nas que mais combinam com seu perfil e localização.',
      ),
      (
        icon: Icons.add_circle_outline,
        title: 'Crie Suas Partidas',
        desc:
            'Organize suas próprias partidas definindo local, data e horário, e aprove os jogadores que desejam participar.',
      ),
      (
        icon: Icons.location_on,
        title: 'Escolha sua Posição',
        desc:
            'Selecione a posição que deseja jogar no campo de futebol society visualizado na plataforma.',
      ),
      (
        icon: Icons.event_available,
        title: 'Gerencie suas Partidas',
        desc:
            'Acompanhe suas partidas marcadas e criadas, aprove solicitações de participação e gerencie os jogadores.',
      ),
      (
        icon: Icons.star_border,
        title: 'Avalie e Seja Avaliado',
        desc:
            'Após as partidas, avalie os jogadores ou o criador e construa sua reputação na plataforma.',
      ),
      (
        icon: Icons.chat_bubble_outline,
        title: 'Comunique-se',
        desc:
            'Use o sistema de chat para conversar com outros jogadores e organizar melhor suas partidas.',
      ),
      (
        icon: Icons.emoji_events,
        title: 'Jogue e Divirta-se!',
        desc:
            'Compareça no local e horário marcado e aproveite sua partida de futebol society!',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: 26,
        mainAxisSpacing: 26,
        childAspectRatio: isMobile ? 3.2 : 3.5,
      ),
      itemCount: steps.length,
      itemBuilder: (ctx, i) {
        final s = steps[i];
        return _TutorialCard(
          icon: s.icon,
          title: s.title,
          desc: s.desc,
          isMobile: isMobile,
        );
      },
    );
  }
}

// Card do tutorial
class _TutorialCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final bool isMobile;

  const _TutorialCard({
    required this.icon,
    required this.title,
    required this.desc,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 24 : 34,
        horizontal: isMobile ? 18 : 28,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF00FF00), width: 2),
        boxShadow: [
          BoxShadow(color: Colors.green.withOpacity(0.13), blurRadius: 18),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: isMobile ? 36 : 54, color: const Color(0xFF00FF00)),
          SizedBox(width: isMobile ? 13 : 26),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: isMobile ? 22 : 29,
                    shadows: [
                      Shadow(
                        color: Colors.greenAccent.withOpacity(0.25),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 5 : 8),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: isMobile ? 13.5 : 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Botão neon (usando o seu padrão)
class _NeonButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  final double? fontSize;
  final double? iconSize;
  final bool darkButton;

  const _NeonButton({
    required this.text,
    required this.icon,
    required this.onTap,
    this.filled = false,
    this.fontSize,
    this.iconSize,
    this.darkButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled
          ? const Color(0xFF00FF00)
          : (darkButton ? Colors.black : Colors.transparent),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: filled
                ? null
                : Border.all(color: const Color(0xFF00FF00), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FF00).withOpacity(0.20),
                blurRadius: 18,
                spreadRadius: filled ? 5 : 2,
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
                size: iconSize ?? 26,
              ),
              const SizedBox(width: 14),
              Text(
                text,
                style: TextStyle(
                  color: filled ? Colors.black : const Color(0xFF00FF00),
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize ?? 21,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: const Color(0xFF00FF00).withOpacity(0.18),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
