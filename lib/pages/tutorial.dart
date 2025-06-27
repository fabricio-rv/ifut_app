import 'package:flutter/material.dart';

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
            horizontal: isMobile ? 16 : 48,
            vertical: isMobile ? 18 : 44,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: isMobile ? 30 : 54),
              // PLAYER + TEXTO NA MESMA LINHA
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    size: isMobile ? 38 : 56,
                    color: const Color(0xFF00FF00),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Como Funciona o ',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 40,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              shadows: [
                                Shadow(
                                  color: Colors.greenAccent.withOpacity(0.9),
                                  blurRadius: 16,
                                ),
                              ],
                            ),
                          ),
                          TextSpan(
                            text: 'IFUT',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 40,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF00FF00),
                              letterSpacing: 0.5,
                              shadows: [
                                Shadow(
                                  color: Colors.greenAccent.withOpacity(0.95),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _TutorialSteps(isMobile: isMobile),
              const SizedBox(height: 44),
              Column(
                children: [
                  Text(
                    'Pronto para começar?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 28 : 38,
                      shadows: [
                        Shadow(
                          color: Colors.greenAccent.withOpacity(0.7),
                          blurRadius: 22,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _NeonButton(
                    text: 'Cadastrar-se Agora',
                    icon: Icons.rocket_launch_outlined,
                    filled: true,
                    fontSize: isMobile ? 22 : 28,
                    iconSize: isMobile ? 23 : 32,
                    onTap: () => Navigator.pushNamed(context, '/tipo_cadastro'),
                  ),
                  const SizedBox(height: 16),
                  _NeonButton(
                    text: 'Login',
                    icon: Icons.login,
                    filled: false,
                    fontSize: isMobile ? 22 : 28,
                    iconSize: isMobile ? 23 : 32,
                    darkButton: true,
                    onTap: () => Navigator.pushNamed(context, '/login'),
                  ),
                  const SizedBox(height: 14),
                  _NeonButton(
                    text: 'Voltar ao início',
                    icon: Icons.arrow_back,
                    filled: false,
                    fontSize: isMobile ? 22 : 28,
                    iconSize: isMobile ? 23 : 32,
                    darkButton: true,
                    onTap: () =>
                        Navigator.popUntil(context, ModalRoute.withName('/')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MESMO _TutorialSteps e _TutorialCard do seu código anterior!

class _TutorialSteps extends StatelessWidget {
  final bool isMobile;
  const _TutorialSteps({required this.isMobile});

  @override
  Widget build(BuildContext context) {
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
            'Explore nossa lista de partidas abertas e solicite participação nas que combinam com seu perfil e localização.',
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

    if (isMobile) {
      return Column(
        children: steps
            .map(
              (s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _TutorialCard(
                  icon: s.icon,
                  title: s.title,
                  desc: s.desc,
                  isMobile: isMobile,
                ),
              ),
            )
            .toList(),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 32,
          mainAxisSpacing: 32,
          childAspectRatio: 2.9,
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
}

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
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 30 : 36,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF00FF00), width: 2.5),
        boxShadow: [
          BoxShadow(color: Colors.green.withOpacity(0.11), blurRadius: 18),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: isMobile ? 48 : 70, color: const Color(0xFF00FF00)),
          SizedBox(width: isMobile ? 18 : 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: isMobile ? 27 : 34,
                    shadows: [
                      Shadow(
                        color: Colors.greenAccent.withOpacity(0.18),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 10 : 15),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.98),
                    fontSize: isMobile ? 18.5 : 22,
                    height: 1.32,
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

// Botão neon
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
    return Container(
      width: double.infinity, // Deixa o botão expandido para centralizar
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Material(
        color: filled
            ? const Color(0xFF00FF00)
            : (darkButton ? const Color(0xFF252525) : Colors.transparent),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: filled ? Colors.black : Colors.white,
                  size: iconSize ?? 32,
                ),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: TextStyle(
                    color: filled ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize ?? 28,
                    letterSpacing: 1.2,
                    shadows: filled
                        ? [
                            Shadow(
                              color: const Color(0xFF00FF00).withOpacity(0.13),
                              blurRadius: 8,
                            ),
                          ]
                        : [],
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
