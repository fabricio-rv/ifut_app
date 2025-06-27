// tipo_cadastro.dart
import 'package:flutter/material.dart';

class TipoCadastroPage extends StatelessWidget {
  const TipoCadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 18 : 60,
              vertical: isMobile ? 26 : 44,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título grande
                Text(
                  'Escolha seu modo de Cadastro',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: isMobile ? 34 : 48,
                    shadows: [
                      Shadow(
                        color: Colors.greenAccent.withOpacity(0.8),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Cards de opções
                Wrap(
                  spacing: isMobile ? 14 : 32,
                  runSpacing: 26,
                  alignment: WrapAlignment.center,
                  children: [
                    _TipoCard(
                      title: "Jogador",
                      icon: Icons.sports_soccer,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/cadastro_jogador',
                          arguments: "jogador",
                        );
                      },
                      isMobile: isMobile,
                    ),
                    _TipoCard(
                      title: "Técnico",
                      icon: Icons.sports,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/cadastro_tecnico',
                          arguments: "tecnico",
                        );
                      },
                      isMobile: isMobile,
                    ),
                    _TipoCard(
                      title: "Torcedor",
                      icon: Icons.emoji_emotions,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/cadastro_torcedor',
                          arguments: "torcedor",
                        );
                      },
                      isMobile: isMobile,
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                // Voltar para início
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Voltar",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: isMobile ? 20 : 26,
                      fontWeight: FontWeight.w700,
                    ),
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

class _TipoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isMobile;
  const _TipoCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: isMobile ? 145 : 210,
          height: isMobile ? 145 : 210,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF00FF00), width: 3.0),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FF00).withOpacity(0.12),
                blurRadius: 16,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFF00FF00),
                size: isMobile ? 48 : 72,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 23 : 30,
                  letterSpacing: 0.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
