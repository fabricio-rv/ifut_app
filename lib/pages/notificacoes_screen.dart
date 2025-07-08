import 'package:flutter/material.dart';

class NotificacoesScreen extends StatelessWidget {
  const NotificacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/teste.png'),
            ),
            title: Text(
              "Lucas curtiu sua foto",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Agora mesmo",
              style: TextStyle(color: Colors.white60),
            ),
            trailing: Icon(Icons.favorite, color: Colors.greenAccent),
            onTap: () {},
          ),
          // ...adicione mais notificações mock
        ],
      ),
    );
  }
}
