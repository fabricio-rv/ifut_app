import 'package:flutter/material.dart';
import 'widgets/insta/stories_bar.dart';
import 'widgets/insta/feed_list.dart';
import 'widgets/insta/bottomnavigationbar.dart';
import 'buscar_screen.dart';
import 'chat_list_screen.dart';
import 'chat_screen.dart'; // Supondo que FeedListScreen existe
import 'buscar_screen.dart'; // Crie essa!
import 'notificacoes_screen.dart'; // Crie essa!
import 'perfil_screen.dart'; // Crie essa!
import 'menu_principal.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool menuAberto = false;
  int _selectedIndex = 0;

  void toggleMenu() => setState(() => menuAberto = !menuAberto);

  // Suas telas. Troque pelos widgets reais do seu projeto!
  final List<Widget> _screens = [
    FeedList(), // Seu feed de posts
    BuscarScreen(), // A tela de busca (crie um arquivo buscar_screen.dart)
    Container(), // Criar (aberto por modal)
    NotificacoesScreen(), // Tela de notificações (crie um arquivo notificacoes_screen.dart)
    PerfilScreen(), // Tela de perfil (crie um arquivo perfil_screen.dart)
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _onCreatePressed();
      return;
    }
    setState(() => _selectedIndex = index);
  }

  void _onCreatePressed() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            top: 35,
            bottom: 0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Criar postagem",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.greenAccent),
                title: Text('Foto', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context), // TODO: Adicionar lógica
              ),
              ListTile(
                leading: Icon(Icons.videocam, color: Colors.greenAccent),
                title: Text('Vídeo', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context), // TODO: Adicionar lógica
              ),
              ListTile(
                leading: Icon(Icons.text_fields, color: Colors.greenAccent),
                title: Text('Texto', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context), // TODO: Adicionar lógica
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      // Troca o corpo da página conforme o _selectedIndex
      body: Stack(
        children: [
          // Troca a tela conforme o _selectedIndex
          IndexedStack(
            index: _selectedIndex,
            children: [
              // 0 - Feed
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                      top: 24,
                      bottom: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.greenAccent,
                            size: 32,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MenuPrincipalPage(),
                              ),
                            );
                          },
                          tooltip: 'Abrir menu principal',
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.chat,
                            color: Colors.greenAccent,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatListScreen(),
                              ), // ou ChatScreen()
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const StoriesBar(),
                  const SizedBox(height: 4),
                  const FeedList(),
                ],
              ),
              // 1 - Buscar
              BuscarScreen(),
              // 2 - Vazio (modal Criar)
              Container(),
              // 3 - Notificações
              NotificacoesScreen(),
              // 4 - Perfil
              PerfilScreen(),
            ],
          ),
          if (menuAberto)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(
                color: Colors.black.withOpacity(0.45),
                child: Row(
                  children: [
                    Container(
                      width: 190,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1A10).withOpacity(0.97),
                        border: Border(
                          right: BorderSide(
                            color: Colors.greenAccent.shade700,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarIFut(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
