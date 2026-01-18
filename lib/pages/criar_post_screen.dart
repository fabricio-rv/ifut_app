import 'package:flutter/material.dart';

class CriarPostScreen extends StatelessWidget {
  const CriarPostScreen({super.key});

  void _showModalTipo(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.greenAccent),
            title: Text("Foto", style: TextStyle(color: Colors.white)),
            onTap: () {}, // lógica de foto
          ),
          ListTile(
            leading: Icon(Icons.videocam, color: Colors.greenAccent),
            title: Text("Vídeo", style: TextStyle(color: Colors.white)),
            onTap: () {}, // lógica de vídeo
          ),
          ListTile(
            leading: Icon(Icons.text_fields, color: Colors.greenAccent),
            title: Text("Texto", style: TextStyle(color: Colors.white)),
            onTap: () {}, // lógica de texto
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () => _showModalTipo(context),
          icon: Icon(Icons.add, color: Colors.black),
          label: Text("Nova postagem", style: TextStyle(color: Colors.black)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            shape: StadiumBorder(),
          ),
        ),
      ),
    );
  }
}
