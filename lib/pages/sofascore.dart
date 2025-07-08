import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/principal/app_background.dart';
import 'widgets/principal/xp_header.dart';
import 'widgets/jogos_recomendados_bar.dart';

class SofaScorePage extends StatefulWidget {
  const SofaScorePage({super.key});

  @override
  State<SofaScorePage> createState() => _SofaScorePageState();
}

class _SofaScorePageState extends State<SofaScorePage> {
  int _selectedDay = 0;
  final List<String> _days = [
    'HOJE',
    'AMANHÃ',
    'SEG',
    'TER',
    'QUA',
    'QUI',
    'SEX',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();

    return Scaffold(
      body: Stack(
        children: [
          AppBackground(
            child: SafeArea(
              child: Column(
                children: [
                  // Barra de jogos recomendados (topo)
                  const JogosRecomendadosBar(),

                  // Cabeçalho com dias
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _days.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDay = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: _selectedDay == index
                                      ? Colors.greenAccent
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _days[index],
                                style: TextStyle(
                                  color: _selectedDay == index
                                      ? Colors.greenAccent
                                      : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Lista de partidas
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: [
                        _buildLeagueSection('CAMPEONATO BRASILEIRO', [
                          _buildMatchItem(
                            homeTeam: 'Flamengo',
                            awayTeam: 'Palmeiras',
                            homeScore: 2,
                            awayScore: 1,
                            time: 'FINALIZADO',
                            minute: '90\'',
                          ),
                          _buildMatchItem(
                            homeTeam: 'São Paulo',
                            awayTeam: 'Corinthians',
                            homeScore: null,
                            awayScore: null,
                            time: '21:00',
                            minute: '',
                          ),
                        ]),

                        _buildLeagueSection('LA LIGA', [
                          _buildMatchItem(
                            homeTeam: 'Barcelona',
                            awayTeam: 'Real Madrid',
                            homeScore: null,
                            awayScore: null,
                            time: '16:00',
                            minute: '',
                          ),
                        ]),

                        _buildLeagueSection('PREMIER LEAGUE', [
                          _buildMatchItem(
                            homeTeam: 'Liverpool',
                            awayTeam: 'Manchester City',
                            homeScore: 1,
                            awayScore: 1,
                            time: 'FINALIZADO',
                            minute: '90\'',
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botão de voltar
          Positioned(
            top: MediaQuery.of(context).padding.top + 770,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueSection(String leagueName, List<Widget> matches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Text(
            leagueName,
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ...matches,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMatchItem({
    required String homeTeam,
    required String awayTeam,
    required int? homeScore,
    required int? awayScore,
    required String time,
    required String minute,
  }) {
    final isFinished = time == 'FINALIZADO';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              homeTeam,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                if (isFinished)
                  Text(
                    '$homeScore - $awayScore',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                else
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                if (minute.isNotEmpty)
                  Text(
                    minute,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
              ],
            ),
          ),

          Expanded(
            child: Text(
              awayTeam,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
