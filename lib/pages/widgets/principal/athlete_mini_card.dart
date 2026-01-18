import 'package:flutter/material.dart';
import 'mini_stat.dart'; // Import the MiniStat widget

class AthleteMiniCard extends StatelessWidget {
  const AthleteMiniCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Fictitious recent game results: 'win', 'loss', 'draw'
    final List<String> recentGames = ["win", "loss", "draw", "win", "win"];

    Color getGameResultColor(String result) {
      switch (result) {
        case "win":
          return Colors.green;
        case "loss":
          return Colors.red;
        case "draw":
          return Colors.grey;
        default:
          return Colors.grey;
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/atleta'); // Navigate to seu_atleta.dart
      },
      child: Container(
        height: size.height * 0.15,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.60),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.greenAccent.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // Square corners
              child: Image.asset(
                'assets/teste.png', // Use the new square image
                width: size.height * 0.07, // Adjust size to fit the card
                height: size.height * 0.07,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "FABÃO",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const MiniStat(icon: Icons.sports_soccer, value: "21"),
                      const SizedBox(width: 10),
                      const MiniStat(
                        icon: Icons.assistant,
                        value: "15",
                      ), // Added Assists
                      const SizedBox(width: 10),
                      const MiniStat(icon: Icons.emoji_events, value: "3"),
                      const SizedBox(width: 10),
                      const MiniStat(icon: Icons.flag, value: "11"),
                      const SizedBox(width: 10),
                      const Icon(Icons.verified, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.military_tech,
                        color: Colors.blueAccent,
                        size: 11,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: recentGames.map((result) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: getGameResultColor(result),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }).toList(),
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
