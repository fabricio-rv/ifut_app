// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/tutorial.dart';
import 'pages/tipo_cadastro.dart';
import 'pages/login.dart';
import 'pages/esqueceu_senha.dart';
import 'pages/cadastro_jogador.dart';
import 'pages/cadastro_tecnico.dart';
import 'pages/cadastro_torcedor.dart';
import 'pages/feed_screen.dart';
import 'pages/buscar_screen.dart';
import 'pages/criar_post_screen.dart';
import 'pages/notificacoes_screen.dart';
import 'pages/perfil_screen.dart';
import 'pages/chat_list_screen.dart';
import 'pages/chat_screen.dart';
import 'pages/menu_principal.dart';
import 'pages/ligas.dart';
import 'pages/partidas.dart';
import 'pages/matchmakings.dart';
import 'pages/times.dart';
import 'pages/atleta.dart';
import 'pages/sofascore.dart';
import 'pages/config.dart';
import 'pages/loja.dart';
import 'pages/sofascore.dart';
import 'pages/atleta.dart';
import 'pages/ranking.dart';

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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ2a2VheHdvd2Rjdm9pZXBha3JkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEwOTAxMTIsImV4cCI6MjA2NjY2NjExMn0.h5427wPvIppADD4OGVpKAKLJWfDxLND_8CMFzQoreuI',
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
        initialRoute: '/menu_principal',
        routes: {
          '/': (context) => const LoginPage(),
          '/tutorial': (context) => const TutorialPage(),
          '/tipo_cadastro': (context) => const TipoCadastroPage(),
          '/esqueceu_senha': (context) => const EsqueceuSenhaPage(),
          '/cadastro_jogador': (context) => const CadastroJogadorPage(),
          '/cadastro_tecnico': (context) => const CadastroTecnicoPage(),
          '/cadastro_torcedor': (context) => const CadastroTorcedorPage(),
          '/feed_screen': (context) => const FeedScreen(),
          '/buscar': (context) => const BuscarScreen(),
          '/criar_post': (context) => const CriarPostScreen(),
          '/notificacoes': (context) => const NotificacoesScreen(),
          '/perfil': (context) => const PerfilScreen(),
          '/chat_list': (context) => const ChatListScreen(),
          '/chat': (context) => const ChatScreen(),
          '/menu_principal': (context) => const MenuPrincipalPage(),
          '/ligas': (context) => const LigasPage(),
          '/partidas': (context) => const PartidasPage(),
          '/matchmaking': (context) => const MatchmakingPage(),
          '/times': (context) => const TimesPage(),
          '/loja': (context) => const LojaPage(),
          '/sofascore': (context) => const SofaScorePage(),
          '/ranking': (context) => const RankingPage(),
          '/atleta': (context) =>
              AtletaScreen(jogador: mockJogadorData), // Sem const
        },
      ),
    );
  }
}
