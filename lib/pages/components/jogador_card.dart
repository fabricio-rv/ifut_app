import 'package:flutter/material.dart';

class JogadorCard extends StatelessWidget {
  final String nome;
  final String apelido;
  final String fotoUrl;
  final String nacionalidade;
  final int overall;
  final int nivel;
  final String posicaoPrincipal;
  final List<String> posicoesSecundarias;
  final String peDominante;
  final double altura;
  final double peso;
  final String escudoClube;
  final String tipoPerfil;
  final List<String> niveis;
  final List<String> badges;
  final List<String> estilosTaticos;
  final List<String> niveisQueTreina;
  final String experiencia;
  final String disponibilidade;

  const JogadorCard({
    super.key,
    required this.nome,
    required this.apelido,
    required this.fotoUrl,
    required this.nacionalidade,
    required this.overall,
    required this.nivel,
    required this.posicaoPrincipal,
    required this.posicoesSecundarias,
    required this.peDominante,
    required this.altura,
    required this.peso,
    required this.escudoClube,
    required this.tipoPerfil,
    required this.niveis,
    required this.badges,
    required this.estilosTaticos,
    required this.niveisQueTreina,
    required this.experiencia,
    required this.disponibilidade,
  });

  @override
  Widget build(BuildContext context) {
    // Aqui você pode copiar o código do JogadorTecnicoCard ou similar,
    // e ajustar para usar os parâmetros acima.
    return Container(
      // Exemplo simples, personalize conforme seu layout
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.greenAccent.withOpacity(0.2), blurRadius: 12),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: fotoUrl.isNotEmpty ? NetworkImage(fotoUrl) : null,
            radius: 40,
            child: fotoUrl.isEmpty ? Icon(Icons.person, size: 45) : null,
          ),
          const SizedBox(height: 8),
          Text(
            nome,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            apelido,
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          ),
          // ...adicione os outros campos conforme desejar
        ],
      ),
    );
  }
}
