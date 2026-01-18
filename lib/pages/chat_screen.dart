import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage('assets/teste.png')),
            const SizedBox(width: 12),
            Text("Lucas Oliveira", style: TextStyle(color: Colors.white)),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.greenAccent),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      "E aí, viu o jogo ontem?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      "Vi sim, golaço demais!",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                // ...mais mensagens
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Mensagem...",
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.greenAccent, size: 28),
                  onPressed: () {}, // Enviar mensagem mock
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
