import 'package:flutter/material.dart';
import 'widgets/principal/app_background.dart';
import 'widgets/principal/xp_header.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

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
                  // Espaço para o header
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                children: [
                  // Título e botão de voltar
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'RANKING GERAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // TOP 3 JOGADORES DA SEMANA
                  _buildTopPlayersSection(),
                  SizedBox(height: 20),

                  // TOP 3 TIMES DA SEMANA
                  _buildTopTeamsSection(),
                  SizedBox(height: 20),

                  // RANKING DE JOGADORES (TOP 10)
                  _buildRankingSection(
                    title: 'TOP 10 JOGADORES',
                    icon: Icons.emoji_events,
                    items: List.generate(
                      10,
                      (index) => _PlayerRank(
                        position: index + 1,
                        name: 'Jogador ${index + 1}',
                        xp: 2500 - (index * 200),
                        avatar: 'assets/avatar_${(index % 3) + 1}.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // RANKING DE LIGAS (TOP 10)
                  _buildRankingSection(
                    title: 'TOP 10 LIGAS',
                    icon: Icons.flag,
                    items: List.generate(
                      10,
                      (index) => _LeagueRank(
                        position: index + 1,
                        name: 'Liga ${index + 1}',
                        members: 50 - (index * 3),
                        matches: 120 - (index * 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // RANKING DE TIMES (TOP 10)
                  _buildRankingSection(
                    title: 'TOP 10 TIMES',
                    icon: Icons.groups,
                    items: List.generate(
                      10,
                      (index) => _TeamRank(
                        position: index + 1,
                        name: 'Time ${index + 1}',
                        wins: 25 - (index * 2),
                        draws: 5,
                        losses: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPlayersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24),
              SizedBox(width: 8),
              Text(
                'TOP 3 JOGADORES DA SEMANA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 2º lugar
            _buildTopPlayerCard(
              position: 2,
              name: 'Carlos Silva',
              xp: 980,
              avatar: 'assets/avatar_2.png',
              isHighlighted: false,
            ),

            // 1º lugar (destaque)
            _buildTopPlayerCard(
              position: 1,
              name: 'Ana Oliveira',
              xp: 1250,
              avatar: 'assets/avatar_1.png',
              isHighlighted: true,
            ),

            // 3º lugar
            _buildTopPlayerCard(
              position: 3,
              name: 'Pedro Costa',
              xp: 850,
              avatar: 'assets/avatar_3.png',
              isHighlighted: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopPlayerCard({
    required int position,
    required String name,
    required int xp,
    required String avatar,
    required bool isHighlighted,
  }) {
    return Column(
      children: [
        if (!isHighlighted) SizedBox(height: 30),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: isHighlighted ? 110 : 90,
              padding: EdgeInsets.all(isHighlighted ? 16 : 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isHighlighted ? Colors.amber : Colors.greenAccent,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '#$position',
                    style: TextStyle(
                      color: isHighlighted ? Colors.amber : Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  CircleAvatar(
                    radius: isHighlighted ? 30 : 25,
                    backgroundImage: AssetImage(avatar),
                  ),
                  SizedBox(height: 8),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isHighlighted ? 14 : 12,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        xp.toString(),
                        style: TextStyle(color: Colors.amber, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isHighlighted)
              Positioned(
                top: -20,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                  child: Icon(Icons.emoji_events, color: Colors.black),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopTeamsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24),
              SizedBox(width: 8),
              Text(
                'TOP 3 TIMES DA SEMANA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTopTeamCard(
                position: 1,
                name: 'Dragões FC',
                wins: 8,
                isHighlighted: true,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _buildTopTeamCard(
                position: 2,
                name: 'Trovão AZ',
                wins: 7,
                isHighlighted: false,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _buildTopTeamCard(
                position: 3,
                name: 'Fênix United',
                wins: 6,
                isHighlighted: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopTeamCard({
    required int position,
    required String name,
    required int wins,
    required bool isHighlighted,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted ? Colors.amber : Colors.greenAccent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '#$position',
                style: TextStyle(
                  color: isHighlighted ? Colors.amber : Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (isHighlighted) ...[
                SizedBox(width: 4),
                Icon(Icons.emoji_events, color: Colors.amber, size: 16),
              ],
            ],
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isHighlighted ? 16 : 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, color: Colors.amber, size: 16),
              SizedBox(width: 4),
              Text(
                '$wins vitórias',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRankingSection({
    required String title,
    required IconData icon,
    required List<dynamic> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Icon(icon, color: Colors.greenAccent, size: 24),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0)
                  Divider(height: 1, color: Colors.white.withOpacity(0.2)),
                _buildRankingItem(items[i], i + 1),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankingItem(dynamic item, int position) {
    if (item is _PlayerRank) {
      return _buildPlayerRankingItem(item, position);
    } else if (item is _LeagueRank) {
      return _buildLeagueRankingItem(item, position);
    } else if (item is _TeamRank) {
      return _buildTeamRankingItem(item, position);
    }
    return Container();
  }

  Widget _buildPlayerRankingItem(_PlayerRank player, int position) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(player.avatar)),
      title: Text(player.name, style: TextStyle(color: Colors.white)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.amber, size: 16),
          SizedBox(width: 4),
          Text(player.xp.toString(), style: TextStyle(color: Colors.amber)),
        ],
      ),
      subtitle: Text(
        'Nível ${(player.xp / 100).floor()}',
        style: TextStyle(color: Colors.white70),
      ),
      dense: true,
    );
  }

  Widget _buildLeagueRankingItem(_LeagueRank league, int position) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey[800],
        ),
        child: Center(
          child: Text(
            position.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      title: Text(league.name, style: TextStyle(color: Colors.white)),
      trailing: Text(
        '${league.members} membros',
        style: TextStyle(color: Colors.white70),
      ),
      dense: true,
    );
  }

  Widget _buildTeamRankingItem(_TeamRank team, int position) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey[800],
          image: DecorationImage(
            image: AssetImage('assets/team_${position % 3 + 1}.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(team.name, style: TextStyle(color: Colors.white)),
      subtitle: Text(
        '${team.wins}V ${team.draws}E ${team.losses}D',
        style: TextStyle(color: Colors.white70),
      ),
      trailing: Text(
        '${((team.wins / (team.wins + team.draws + team.losses)) * 100).toStringAsFixed(1)}%',
        style: TextStyle(color: Colors.greenAccent),
      ),
      dense: true,
    );
  }
}

// Modelos para os rankings
class _PlayerRank {
  final int position;
  final String name;
  final int xp;
  final String avatar;

  _PlayerRank({
    required this.position,
    required this.name,
    required this.xp,
    required this.avatar,
  });
}

class _LeagueRank {
  final int position;
  final String name;
  final int members;
  final int matches;

  _LeagueRank({
    required this.position,
    required this.name,
    required this.members,
    required this.matches,
  });
}

class _TeamRank {
  final int position;
  final String name;
  final int wins;
  final int draws;
  final int losses;

  _TeamRank({
    required this.position,
    required this.name,
    required this.wins,
    required this.draws,
    required this.losses,
  });
}
