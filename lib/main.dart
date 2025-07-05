// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // <-- Adicione essa linha!
import 'pages/tutorial.dart';
import 'pages/tipo_cadastro.dart';
import 'pages/login.dart';
import 'pages/esqueceu_senha.dart';
import 'pages/cadastro_jogador.dart';
import 'pages/cadastro_tecnico.dart';
import 'pages/cadastro_torcedor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

import 'pages/controllers/dados_pessoais_controller.dart';
import 'pages/controllers/caracteristicas_fisicas_controller.dart';
import 'pages/controllers/localizacao_controller.dart';

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
  runApp(const IFutApp());
}

class IFutApp extends StatelessWidget {
  const IFutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DadosPessoaisController()),
        ChangeNotifierProvider(
          create: (_) => CaracteristicasFisicasController(),
        ),
        ChangeNotifierProvider(create: (_) => LocalizacaoController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FUT7',
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/tutorial': (context) => const TutorialPage(),
          '/tipo_cadastro': (context) => const TipoCadastroPage(),
          '/esqueceu_senha': (context) => const EsqueceuSenhaPage(),
          '/cadastro_jogador': (context) => const CadastroJogadorPage(),
          '/cadastro_tecnico': (context) => const CadastroTecnicoPage(),
          '/cadastro_torcedor': (context) => const CadastroTorcedorPage(),
        },
      ),
    );
  }
}
