import 'package:flutter/material.dart';
import 'pages/tutorial.dart';
import 'pages/tipo_cadastro.dart';
import 'pages/login.dart';
import 'pages/esqueceu_senha.dart';
import 'pages/cadastro_jogador.dart';
import 'pages/cadastro_tecnico.dart';
import 'pages/cadastro_torcedor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart'; // <-- ESSA LINHA AQUI!

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Supabase.initialize(
    url: 'https://fvkeaxwowdcvoiepakrd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ2a2VheHdvd2Rjdm9pZXBha3JkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEwOTAxMTIsImV4cCI6MjA2NjY2NjExMn0.h5427wPvIppADD4OGVpKAKLJWfDxLND_8CMFzQoreuI', // cole o valor copiado!
  );
  runApp(const IFutApp()); // ou seu widget principal
}

class IFutApp extends StatelessWidget {
  const IFutApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FUT7',
      theme: ThemeData.dark(),
      initialRoute: '/', // sua home
      routes: {
        '/': (context) => const LoginPage(),
        '/tutorial': (context) => const TutorialPage(),
        '/tipo_cadastro': (context) => const TipoCadastroPage(),
        '/esqueceu_senha': (context) => const EsqueceuSenhaPage(),
        '/cadastro_jogador': (context) => const CadastroJogadorPage(),
        '/cadastro_tecnico': (context) => const CadastroTecnicoPage(),
        '/cadastro_torcedor': (context) => const CadastroTorcedorPage(),
      },
    );
  }
}
