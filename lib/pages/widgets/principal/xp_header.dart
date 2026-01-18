import 'package:flutter/material.dart';

class XPHeader extends StatelessWidget {
  final String nomeUsuario;
  final String nivel;
  final double xpAtual;
  final double xpProximoNivel;

  const XPHeader({
    super.key,
    required this.nomeUsuario,
    required this.nivel,
    required this.xpAtual,
    required this.xpProximoNivel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar + Nível (simplificado)
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.greenAccent, Colors.blueAccent],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              nivel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Nome + Progresso
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, $nomeUsuario!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: xpAtual / xpProximoNivel,
                    backgroundColor: Colors.white10,
                    color: Colors.greenAccent,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'XP ${xpAtual.toInt()}/${xpProximoNivel.toInt()}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
