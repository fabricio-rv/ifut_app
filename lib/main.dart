import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/tutorial.dart';
import 'pages/tipo_cadastro.dart';
import 'pages/login.dart';
import 'pages/esqueceu_senha.dart';

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
      initialRoute: '/', // sua home
      routes: {
        '/': (context) => const HomePage(),
        '/tutorial': (context) => const TutorialPage(),
        '/tipo_cadastro': (context) => const TipoCadastroPage(),
        '/login': (context) => const LoginPage(),
        '/esqueceu_senha': (context) => const EsqueceuSenhaPage(),
      },
    );
  }
}
