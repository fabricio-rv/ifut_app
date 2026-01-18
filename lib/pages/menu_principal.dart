import 'package:flutter/material.dart';
import 'widgets/principal/app_background.dart';
import 'widgets/principal/home_menu_card.dart';
import 'widgets/principal/athlete_mini_card.dart';
import 'widgets/principal/sofascore_card.dart';
import 'widgets/principal/ranking_card.dart';
import 'widgets/menu_navigationbar.dart';
import 'widgets/sair.dart';
import 'widgets/principal/xp_header.dart';

class MenuPrincipalPage extends StatefulWidget {
  const MenuPrincipalPage({super.key});

  @override
  State<MenuPrincipalPage> createState() => _MenuPrincipalPageState();
}

class _MenuPrincipalPageState extends State<MenuPrincipalPage> {
  int _currentIndex = 0;

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
                  top: 80, // Altura aproximada do header
                  bottom: 80, // Altura da navigation bar
                  left: 16,
                  right: 16,
                ),
                children: [
                  SizedBox(height: size.height * 0.02),
                  // Seu Atleta (mini-card com estatísticas)
                  const AthleteMiniCard(),
                  SizedBox(height: size.height * 0.015),
                  // Cards Principais
                  Row(
                    children: [
                      Expanded(
                        child: HomeMenuCard(
                          title: 'LIGAS',
                          subtitle: '',
                          icon: Icons.emoji_events,
                          onTap: () {
                            Navigator.pushNamed(context, '/ligas');
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: HomeMenuCard(
                          title: 'PARTIDAS',
                          subtitle: '',
                          icon: Icons.sports_soccer,
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
                          title: 'MATCHMAKING',
                          subtitle: '',
                          icon: Icons.person_search,
                          onTap: () {
                            Navigator.pushNamed(context, '/matchmaking');
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: HomeMenuCard(
                          title: 'TIMES',
                          subtitle: '',
                          icon: Icons.sports,
                          onTap: () {
                            Navigator.pushNamed(context, '/times');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.015),
                  // Sofascore / Estatísticas Preview
                  const SofaScoreCard(),
                  SizedBox(height: size.height * 0.015),
                  // Ranking Geral do App (top 3)
                  const RankingCard(),
                  SizedBox(height: size.height * 0.01),
                ],
              ),
            ),
          ),
          // 1. No seu widget principal (onde usa o Stack):
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              // Adicionei Material widget
              elevation: 4, // Sombra sutil
              child: Container(
                color: Colors.black.withOpacity(0.9), // Opacidade aumentada
                child: SafeArea(
                  bottom: false,
                  child: XPHeader(
                    nomeUsuario: "Fabricio",
                    nivel: "63",
                    xpAtual: 135,
                    xpProximoNivel: 300,
                  ),
                ),
              ),
            ),
          ),

          // Fixed Navigation Bar at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MainNavigationBar(
              currentIndex: _currentIndex,
              onTabSelected: (index) {
                setState(() => _currentIndex = index);
                switch (index) {
                  case 0:
                    if (ModalRoute.of(context)?.settings.name !=
                        '/menu_principal') {
                      Navigator.pushReplacementNamed(
                        context,
                        '/menu_principal',
                      );
                    }
                    break;
                  case 1:
                    if (ModalRoute.of(context)?.settings.name !=
                        '/feed_screen') {
                      Navigator.pushReplacementNamed(context, '/feed_screen');
                    }
                    break;
                  case 2:
                    if (ModalRoute.of(context)?.settings.name != '/loja') {
                      Navigator.pushReplacementNamed(context, '/loja');
                    }
                    break;
                  case 3:
                    if (ModalRoute.of(context)?.settings.name != '/config') {
                      Navigator.pushReplacementNamed(
                        context,
                        '/config',
                      ); // Corrigido
                    }
                  case 4:
                    showLogoutDialog(context);
                    break;
                }
              },
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
