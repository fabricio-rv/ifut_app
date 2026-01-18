import 'package:flutter/material.dart';
import 'story_bubble.dart';

class StoriesBar extends StatelessWidget {
  const StoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      StoryMock(
        usuario: 'Você',
        imagem: "assets/teste.png",
        isMine: true,
        visto: false,
      ),
      StoryMock(usuario: 'Lucas', imagem: "assets/teste.png", visto: false),
      StoryMock(usuario: 'Maria', imagem: "assets/teste.png", visto: true),
      StoryMock(usuario: 'Léo', imagem: "assets/teste.png", visto: false),
      StoryMock(usuario: 'Bianca', imagem: "assets/teste.png", visto: false),
      StoryMock(usuario: 'André', imagem: "assets/teste.png", visto: true),
    ];

    return ClipRect(
      child: Container(
        height: 110, // aumente conforme desejar
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (context, i) {
            final story = stories[i];
            return StoryBubble(
              usuario: story.usuario,
              imagem: story.imagem,
              visto: story.visto,
              isMine: story.isMine,
            );
          },
        ),
      ),
    );
  }
}

class StoryMock {
  final String usuario;
  final String imagem;
  final bool visto;
  final bool isMine;
  StoryMock({
    required this.usuario,
    required this.imagem,
    this.visto = false,
    this.isMine = false,
  });
}
