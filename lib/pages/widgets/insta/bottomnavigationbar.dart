import 'package:flutter/material.dart';

class BottomNavigationBarIFut extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationBarIFut({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  void _onCreatePressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
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
                onTap: () {
                  Navigator.pop(context);
                  // TODO: adicionar lógica
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam, color: Colors.greenAccent),
                title: Text('Vídeo', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: adicionar lógica
                },
              ),
              ListTile(
                leading: Icon(Icons.text_fields, color: Colors.greenAccent),
                title: Text('Texto', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: adicionar lógica
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Colors.greenAccent.withOpacity(0.11)),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 3),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (i) {
          if (i == 2) {
            _onCreatePressed(context);
            return;
          }
          onItemTapped(i);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(size: 23),
        unselectedIconTheme: const IconThemeData(size: 21),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Feed',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.16),
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(5),
              child: const Icon(Icons.add, color: Colors.black, size: 21),
            ),
            label: 'Criar',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notificações',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
