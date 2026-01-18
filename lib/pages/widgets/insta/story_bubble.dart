import 'package:flutter/material.dart';

class StoryBubble extends StatelessWidget {
  final String usuario;
  final String imagem;
  final bool visto;
  final bool isMine;

  const StoryBubble({
    super.key,
    required this.usuario,
    required this.imagem,
    this.visto = false,
    this.isMine = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isMine
        ? Colors.greenAccent
        : visto
        ? Colors.grey.shade600
        : Colors.pinkAccent.shade100;

    Widget avatar = Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 4),
            boxShadow: [
              BoxShadow(color: borderColor.withOpacity(0.16), blurRadius: 10),
            ],
          ),
          child: ClipOval(
            child: imagem.startsWith('http')
                ? Image.network(
                    imagem,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  )
                : Image.asset(imagem, width: 70, height: 70, fit: BoxFit.cover),
          ),
        ),
        if (isMine)
          Positioned(
            right: 3,
            bottom: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.greenAccent, width: 2),
              ),
              child: const Icon(Icons.add, size: 21, color: Colors.greenAccent),
            ),
          ),
      ],
    );

    // Envolve o avatar em GestureDetector só se for "seu"
    if (isMine) {
      avatar = GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Adicionar Story'),
              content: const Text(
                'Funcionalidade mock: Adicione seu story aqui!',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          );
        },
        child: avatar,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar,
        const SizedBox(height: 7),
        SizedBox(
          width: 55,
          child: Text(
            usuario,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: isMine ? FontWeight.w600 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
