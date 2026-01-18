import 'package:flutter/material.dart';

class BuscarScreen extends StatelessWidget {
  const BuscarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white12,
                prefixIcon: Icon(Icons.search, color: Colors.greenAccent),
                hintText: "Buscar usuários, posts ou clubes...",
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (txt) {
                // lógica de busca real depois
              },
            ),
          ),
          // Resultados mock
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/teste.png'),
                  ),
                  title: Text(
                    "Lucas Oliveira",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Jogador",
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.white54),
                  onTap: () {},
                ),
                // ...adicione outros resultados mock
              ],
            ),
          ),
        ],
      ),
    );
  }
}
