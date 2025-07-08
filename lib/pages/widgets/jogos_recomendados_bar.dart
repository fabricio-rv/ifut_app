import 'package:flutter/material.dart';

// Mock dos escudos
final Map<String, String> escudos = {
  'Flamengo': "assets/escudo_sem_clube.png",
  'Vasco': "assets/escudo_sem_clube.png",
  'Palmeiras': "assets/escudo_sem_clube.png",
  'Corinthians': "assets/escudo_sem_clube.png",
  'São Paulo': "assets/escudo_sem_clube.png",
  'Santos': "assets/escudo_sem_clube.png",
};

class JogosRecomendadosBar extends StatelessWidget {
  const JogosRecomendadosBar({super.key});

  @override
  Widget build(BuildContext context) {
    final jogos = [
      JogoRecomendado(
        timeCasa: 'Flamengo',
        timeFora: 'Vasco',
        siglaCasa: 'FLA',
        siglaFora: 'VAS',
        placarCasa: 2,
        placarFora: 1,
        horario: '19:30',
        status: 'AO VIVO',
        ligaOuTitulo: 'Brasileirão',
      ),
      JogoRecomendado(
        timeCasa: 'Palmeiras',
        timeFora: 'Corinthians',
        siglaCasa: 'PAL',
        siglaFora: 'COR',
        placarCasa: 0,
        placarFora: 0,
        horario: '21:00',
        status: '21:00',
        ligaOuTitulo: 'Paulistão',
      ),
      JogoRecomendado(
        timeCasa: 'São Paulo',
        timeFora: 'Santos',
        siglaCasa: 'SAO',
        siglaFora: 'SAN',
        placarCasa: 3,
        placarFora: 2,
        horario: '17:45',
        status: 'ENCERRADO',
        ligaOuTitulo: 'Pelada de Quarta',
      ),
    ];

    return Container(
      height: 110, // Ajuste de altura para caber tudo bonitinho!
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: jogos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => _JogoRecomendadoCard(jogo: jogos[i]),
      ),
    );
  }
}

class _JogoRecomendadoCard extends StatelessWidget {
  final JogoRecomendado jogo;
  const _JogoRecomendadoCard({required this.jogo});

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.white;
    if (jogo.status == 'AO VIVO') statusColor = Colors.greenAccent;
    if (jogo.status == 'ENCERRADO') statusColor = Colors.redAccent.shade200;

    return Container(
      width: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black.withOpacity(0.93),
        border: Border.all(color: statusColor.withOpacity(0.37), width: 2),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.09),
            blurRadius: 7,
            spreadRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Liga/título
          Text(
            jogo.ligaOuTitulo,
            style: TextStyle(
              color: Colors.greenAccent.shade100,
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _escudo(jogo.timeCasa),
                const SizedBox(width: 2),
                _sigla(jogo.siglaCasa),
                const SizedBox(width: 5),
                Text(
                  '${jogo.placarCasa}',
                  style: TextStyle(
                    color: Colors.greenAccent.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  ' x ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20, // aumente esse valor até ficar proporcional
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${jogo.placarFora}',
                  style: TextStyle(
                    color: Colors.redAccent.shade100,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 5),
                _sigla(jogo.siglaFora),
                const SizedBox(width: 2),
                _escudo(jogo.timeFora),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            jogo.status,
            style: TextStyle(
              color: statusColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _escudo(String time) {
    final url = escudos[time];
    if (url == null) return const SizedBox(width: 22, height: 22);
    return Container(
      width: 28,
      height: 28,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: Colors.white12, shape: BoxShape.circle),
      child: Image.asset(url, fit: BoxFit.contain),
    );
  }

  Widget _sigla(String sigla) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        sigla,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// Modelo de jogo (igual já estava)
class JogoRecomendado {
  final String timeCasa;
  final String timeFora;
  final String siglaCasa;
  final String siglaFora;
  final int placarCasa;
  final int placarFora;
  final String horario;
  final String status;
  final String ligaOuTitulo;

  JogoRecomendado({
    required this.timeCasa,
    required this.timeFora,
    required this.siglaCasa,
    required this.siglaFora,
    required this.placarCasa,
    required this.placarFora,
    required this.horario,
    required this.status,
    required this.ligaOuTitulo,
  });
}
