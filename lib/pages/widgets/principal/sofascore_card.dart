import 'package:flutter/material.dart';

class SofaScoreCard extends StatelessWidget {
  const SofaScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/sofascore',
        ); // Navigate to sofascore.dart
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.60),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.blueAccent.withOpacity(0.1)),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "ESTATÍSTICAS",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.06,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Veja as Estatísticas Gerais",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.034,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.query_stats,
                color: Colors.blueAccent.withOpacity(0.7),
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
