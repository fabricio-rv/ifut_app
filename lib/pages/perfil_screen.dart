import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Troque pelos dados reais depois
    final usuario = "Lucas Oliveira";
    final tipoPerfil = "Jogador"; // ou "Técnico", "Torcedor"
    final foto = "assets/teste.png";

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(radius: 46, backgroundImage: AssetImage(foto)),
          const SizedBox(height: 14),
          Text(
            usuario,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            tipoPerfil,
            style: TextStyle(color: Colors.greenAccent, fontSize: 17),
          ),
          const SizedBox(height: 10),
          Text(
            "Meu clube favorito: Flamengo",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 14),
          Divider(
            color: Colors.greenAccent,
            indent: 44,
            endIndent: 44,
            thickness: 1,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: Colors.greenAccent),
                  title: Text("Nome", style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    usuario,
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.sports_soccer, color: Colors.greenAccent),
                  title: Text(
                    "Perfil IFut",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    tipoPerfil,
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
                // ...adicione mais dados
              ],
            ),
          ),
        ],
      ),
    );
  }
}
