import 'package:flutter/material.dart';
import 'pages/home.dart'; // Sua tela inicial
import 'pages/tutorial.dart'; // Sua tela de tutorial

void main() {
  runApp(const IFutApp());
}

class IFutApp extends StatelessWidget {
  const IFutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IFUT',
      theme: ThemeData.dark(),
      // Defina qual tela vai abrir primeiro ("/" ou "/tutorial")
      initialRoute: '/', // Troque para '/tutorial' se quiser testar a tutorial
      routes: {
        '/': (context) => const HomePage(),
        '/tutorial': (context) => const TutorialPage(),
      },
    );
  }
}
