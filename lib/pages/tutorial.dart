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
              // Título e ícone
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
                            text: 'FUT7',
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
              const SizedBox(height: 18),
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
                    onTap: () => Navigator.pushNamed(context, '/'),
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

class _TutorialSteps extends StatelessWidget {
  final bool isMobile;
  const _TutorialSteps({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final steps = [
      (
        icon: Icons.sports_soccer_rounded,
        title: 'O que é o FUT7?',
        desc:
            'O FUT7 é a sua plataforma social gamificada para futebol society! Aqui você cria sua cartinha digital, participa de partidas, monta times, disputa campeonatos, ganha badges e compartilha tudo no feed com a comunidade.',
      ),
      (
        icon: Icons.person,
        title: 'Modo Jogador',
        desc:
            'Monte seu perfil, participe de partidas, seja avaliado (OVERALL), evolua de nível (LEVEL), ganhe badges, poste lances, crie times e dispute ligas e rankings!',
      ),
      (
        icon: Icons.groups_2_rounded,
        title: 'Modo Técnico',
        desc:
            'Gerencie times, aprove/recuse jogadores, organize escalação e tática, poste conquistas, dispute campeonatos, acompanhe evolução dos atletas — sem jogar as partidas.',
      ),
      (
        icon: Icons.emoji_events_outlined,
        title: 'Modo Torcedor',
        desc:
            'Siga jogadores, técnicos e times, curta e comente no feed, veja rankings, campeonatos e estatísticas. Experiência completa de comunidade, sem participar das partidas.',
      ),
      (
        icon: Icons.credit_card_rounded,
        title: 'Cartinha FUT7 Personalizada',
        desc:
            'Monte sua cartinha digital: foto, posição, estatísticas, badges, OVERALL, LEVEL e conquistas. Evolua seu perfil a cada jogo!',
      ),
      (
        icon: Icons.feed_rounded,
        title: 'Feed Social da Comunidade',
        desc:
            'Veja lances, conquistas, fotos, rankings e interaja: siga, curta, comente e acompanhe os destaques da galera FUT7.',
      ),
      (
        icon: Icons.sports_soccer_rounded,
        title: 'Participe de Partidas',
        desc:
            'Encontre jogos pelo app, escolha posição e horário, solicite vaga e jogue com gente de todos os níveis e regiões.',
      ),
      (
        icon: Icons.add_circle_outline,
        title: 'Crie e Gerencie Partidas',
        desc:
            'Organize jogos: defina local, regras, aprove ou recuse jogadores, gerencie inscrições e acompanhe tudo pelo app.',
      ),
      (
        icon: Icons.group_rounded,
        title: 'Monte e Gerencie Times',
        desc:
            'Crie um time, personalize escudo e nome, convide jogadores, defina escalação/tática e dispute campeonatos estilo Kings League.',
      ),
      (
        icon: Icons.leaderboard_rounded,
        title: 'Ligas e Campeonatos',
        desc:
            'Participe e organize campeonatos, veja tabelas, rankings, estatísticas de artilharia, prêmios, chaves de mata-mata e muito mais.',
      ),
      (
        icon: Icons.stars_rounded,
        title: 'Badges e Conquistas',
        desc:
            'Ganhe badges automáticas (ex: 100 gols, MVP, Artilheiro, Desafio semanal), mostre no perfil e compartilhe nas redes.',
      ),
      (
        icon: Icons.bar_chart_rounded,
        title: 'Dashboard & Estatísticas',
        desc:
            'Gráficos de desempenho, evolução de OVERALL, XP, badges, partidas, histórico e conquistas do jogador, técnico ou time.',
      ),
      (
        icon: Icons.search,
        title: 'Busca Avançada',
        desc:
            'Encontre jogadores, times, técnicos ou partidas filtrando por cidade, categoria, OVERALL, posição, etc.',
      ),
      (
        icon: Icons.star_border,
        title: 'Sistema de Avaliação',
        desc:
            'Depois de cada jogo, avalie outros participantes e seja avaliado, aumentando (ou não!) seu OVERALL.',
      ),
      (
        icon: Icons.rocket_launch_rounded,
        title: 'Level Up e Gamificação',
        desc:
            'Ganhe XP jogando, organizando, postando e participando de desafios para subir de LEVEL e liberar conquistas exclusivas.',
      ),
      (
        icon: Icons.chat_bubble_outline,
        title: 'Chats e Notificações',
        desc:
            'Converse em tempo real, organize times/jogos, troque mensagens privadas e receba notificações sobre tudo que importa pra você.',
      ),
      (
        icon: Icons.auto_graph,
        title: 'Histórico e Evolução',
        desc:
            'Acompanhe toda sua trajetória no FUT7: partidas, times, conquistas, avaliações, desafios e evolução completa.',
      ),
      (
        icon: Icons.workspace_premium_rounded,
        title: 'FUT7: Seu Futebol, Sua História!',
        desc:
            'Tudo o que você faz na plataforma conta pontos, gera conquistas e te coloca entre os melhores do futebol society digital!',
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
          childAspectRatio: 2.6,
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
                    fontSize: isMobile ? 24 : 31,
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
                    fontSize: isMobile ? 17 : 21,
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
      width: double.infinity,
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
