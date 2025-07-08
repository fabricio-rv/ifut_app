import 'package:flutter/material.dart';
import 'widgets/principal/app_background.dart';
import 'widgets/principal/home_menu_card.dart';
import 'widgets/principal/athlete_mini_card.dart';
import 'widgets/principal/sofascore_card.dart';
import 'widgets/principal/ranking_card.dart';
import 'widgets/menu_navigationbar.dart';
import 'widgets/sair.dart';
import 'widgets/principal/xp_header.dart';

class LigasPage extends StatelessWidget {
  const LigasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AppBackground(
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 90, // Altura aproximada do header
                  bottom: 90, // Altura da navigation bar
                  left: 16,
                  right: 16,
                ),
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'LIGAS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28, // Tamanho aumentado
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.015),
                  // Cards Principais
                  Row(
                    children: [
                      Expanded(
                        child: HomeMenuCard(
                          title: 'CRIAR',
                          subtitle: '',
                          icon: Icons.add_box_rounded,
                          onTap: () {
                            Navigator.pushNamed(context, '/ligas');
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: HomeMenuCard(
                          title: 'PARTICIPAR',
                          subtitle: '',
                          icon: Icons.group_add,
                          onTap: () {
                            Navigator.pushNamed(context, '/partidas');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.015),
                  // Matchmaking
                  Row(
                    children: [
                      Expanded(
                        child: HomeMenuCard(
                          title: 'LIGAS',
                          subtitle: '',
                          icon: Icons.emoji_events,
                          onTap: () {
                            Navigator.pushNamed(context, '/matchmaking');
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: HomeMenuCard(
                          title: 'VISUALIZAR',
                          subtitle: '',
                          icon: Icons.remove_red_eye,
                          onTap: () {
                            Navigator.pushNamed(context, '/times');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.015),

                  // Seção de estatísticas
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SUAS ESTATÍSTICAS',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _LeagueStat(
                              icon: Icons.emoji_events,
                              value: '12',
                              label: 'Títulos',
                            ),
                            _LeagueStat(
                              icon: Icons.star,
                              value: '24',
                              label: 'Vitórias',
                            ),
                            _LeagueStat(
                              icon: Icons.sports_soccer,
                              value: '56',
                              label: 'Jogos',
                            ),
                            _LeagueStat(
                              icon: Icons.show_chart,
                              value: '82%',
                              label: 'Aproveit.',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),

                  // Próximas ligas
                  Text(
                    'PRÓXIMAS LIGAS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  _NextLeagueItem(
                    name: 'Liga F7 São Paulo',
                    date: 'Inicia 15/08',
                    teams: '12 times',
                    prize: 'Prêmio: R\$ 2.500',
                    onTap: () {},
                  ),
                  _NextLeagueItem(
                    name: 'Liga Society SP',
                    date: 'Inicia 22/08',
                    teams: '8 times',
                    prize: 'Prêmio: R\$ 1.200',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Header com XP (igual ao menu principal)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              elevation: 4,
              child: Container(
                color: Colors.black.withOpacity(0.9),
                child: SafeArea(
                  bottom: false,
                  child: XPHeader(
                    nomeUsuario: "Lucas",
                    nivel: "12",
                    xpAtual: 135,
                    xpProximoNivel: 300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeagueStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _LeagueStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueGrey[800]?.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.greenAccent, size: 20),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

class _NextLeagueItem extends StatelessWidget {
  final String name;
  final String date;
  final String teams;
  final String prize;
  final VoidCallback onTap;

  const _NextLeagueItem({
    required this.name,
    required this.date,
    required this.teams,
    required this.prize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blueGrey[800],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/league_badge.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white70,
                        size: 12,
                      ),
                      SizedBox(width: 5),
                      Text(date, style: TextStyle(color: Colors.white70)),
                      SizedBox(width: 15),
                      Icon(Icons.people, color: Colors.white70, size: 14),
                      SizedBox(width: 5),
                      Text(teams, style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    prize,
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'INSCREVER-SE',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
