import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Conversas",
          style: TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
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
              "E aí, viu o jogo ontem?",
              style: TextStyle(color: Colors.white60),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.greenAccent),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen()),
              );
            },
          ),
          // Adicione mais ListTile para outros chats
        ],
      ),
    );
  }
}
