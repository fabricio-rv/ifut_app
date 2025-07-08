import 'package:flutter/material.dart';
import '../config.dart';
import 'sair.dart';

class MainNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final BuildContext context;

  const MainNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Colors.greenAccent.withOpacity(0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _MenuShortcut(
            icon: Icons.home,
            label: 'Home',
            onTap: () => onTabSelected(0),
            isSelected: currentIndex == 0,
          ),
          _MenuShortcut(
            icon: Icons.forum,
            label: 'Feed',
            onTap: () => onTabSelected(1),
            isSelected: currentIndex == 1,
          ),
          _MenuShortcut(
            icon: Icons.shopping_cart, // Ícone para Loja
            label: 'Loja',
            onTap: () => onTabSelected(2),
            isSelected: currentIndex == 2,
          ),
          _MenuShortcut(
            icon: Icons.settings,
            label: 'Config',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigPage()),
              );
            },
            isSelected: currentIndex == 3,
          ),
          _MenuShortcut(
            icon: Icons.logout,
            label: 'Sair',
            onTap: () {
              showLogoutDialog(context);
            },
            isSelected: currentIndex == 4,
          ),
        ],
      ),
    );
  }
}

class _MenuShortcut extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const _MenuShortcut({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.14, // Ajustei para 18% para caber 5 itens
        height: size.width * 0.14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.greenAccent : Colors.white70,
              size: size.width * 0.06, // Reduzi um pouco o tamanho do ícone
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.greenAccent : Colors.white70,
                fontSize:
                    size.width * 0.025, // Reduzi um pouco o tamanho da fonte
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
