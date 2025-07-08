import 'package:flutter/material.dart';
import 'ranking_mini.dart'; // Import the RankingMini widget

class RankingCard extends StatelessWidget {
  const RankingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> topPlayers = [
      {'position': 1, 'name': 'Lucas O.', 'avatar': 'assets/teste.png'},
      {'position': 2, 'name': 'Rafa F.', 'avatar': 'assets/teste.png'},
      {'position': 3, 'name': 'João P.', 'avatar': 'assets/teste.png'},
    ];

    final List<Map<String, dynamic>> topTeams = [
      {
        'position': 1,
        'name': 'Time Alpha',
        'avatar': 'assets/teste.png',
      }, // Avatar can be a placeholder or actual shield
      {'position': 2, 'name': 'Time Beta', 'avatar': 'assets/teste.png'},
      {'position': 3, 'name': 'Time Gamma', 'avatar': 'assets/teste.png'},
    ];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/ranking',
        ); // Navigate to ranking_geral.dart
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.60),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.amber.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RANKING GERAL DO APP',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.045,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            // Top 3 Jogadores
            const Text(
              'Top 3 Jogadores',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: topPlayers.map((player) {
                return RankingMini(
                  position: player['position'],
                  name: player['name'],
                  avatar: player['avatar'],
                  isTeam: false,
                );
              }).toList(),
            ),
            const SizedBox(height: 8), // Space between players and teams
            // Top 3 Times
            const Text(
              'Top 3 Times',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: topTeams.map((team) {
                return RankingMini(
                  position: team['position'],
                  name: team['name'],
                  avatar:
                      team['avatar'], // This avatar can be a shield image or a generic placeholder
                  isTeam: true,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
