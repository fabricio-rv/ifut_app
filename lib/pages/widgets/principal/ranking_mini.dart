import 'package:flutter/material.dart';

class RankingMini extends StatelessWidget {
  final int position;
  final String name;
  final String avatar; // Path to image asset
  final bool isTeam;

  const RankingMini({
    required this.position,
    required this.name,
    required this.avatar,
    this.isTeam = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        // Handle tap for individual player/team in ranking if needed
      },
      child: Column(
        children: [
          isTeam
              ? Container(
                  width: size.width * 0.11, // Adjusted size for square
                  height: size.width * 0.11,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3), // Background for shield
                    borderRadius: BorderRadius.circular(8), // Square corners
                  ),
                  child: Icon(
                    Icons.shield, // Shield icon for teams
                    color: Colors.white70,
                    size: size.width * 0.07,
                  ),
                )
              : CircleAvatar(
                  backgroundImage: AssetImage(avatar),
                  radius: size.width * 0.055,
                ),
          const SizedBox(height: 3),
          Text(
            '#$position',
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.033,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.032,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
