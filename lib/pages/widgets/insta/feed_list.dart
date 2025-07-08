// widgets/feed_list.dart
// widgets/feed_list.dart
import 'package:flutter/material.dart';
import 'feed_post_card.dart'; // ou FeedPost.dart

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = [
      FeedPost(
        usuario: 'Lucas',
        fotoUsuario: "assets/teste.png",
        conteudo: 'Belo gol do nosso time ontem! ⚽🔥',
        imagem: "assets/jogador_fundo.png",
        curtidas: 47,
        comentarios: [
          CommentMock(
            usuario: "Maria",
            fotoUsuario: "assets/teste.png",
            texto: "Show!",
            curtidas: 3,
          ),
          CommentMock(
            usuario: "João",
            fotoUsuario: "assets/teste.png",
            texto: "Massa!",
            curtidas: 1,
          ),
          CommentMock(
            usuario: "Carlinho",
            fotoUsuario: "assets/teste.png",
            texto: "Joga Muito!",
            curtidas: 2,
          ),
        ],
        tempoPost: '1h',
        isCurtido: false,
      ),
      FeedPost(
        usuario: 'Carlos',
        fotoUsuario: "assets/teste.png",
        conteudo: 'Reunião tática antes do jogo decisivo! Vamos juntos 💪',
        imagem: null,
        curtidas: 21,
        comentarios: [
          CommentMock(
            usuario: "Maria",
            fotoUsuario: "assets/teste.png",
            texto: "Show!",
            curtidas: 3,
          ),
          CommentMock(
            usuario: "João",
            fotoUsuario: "assets/teste.png",
            texto: "Massa!",
            curtidas: 1,
          ),
          CommentMock(
            usuario: "Carlinho",
            fotoUsuario: "assets/teste.png",
            texto: "Joga Muito!",
            curtidas: 2,
          ),
        ],
        tempoPost: '2h',
        isCurtido: true,
      ),
      FeedPost(
        usuario: 'Fagner',
        fotoUsuario: "assets/teste.png",
        conteudo: 'Lance bonito da zaga! Veja o vídeo 👇',
        imagem: "assets/tecnico_fundo.png",
        curtidas: 59,
        comentarios: [
          CommentMock(
            usuario: "Maria",
            fotoUsuario: "assets/teste.png",
            texto: "Show!",
            curtidas: 3,
          ),
          CommentMock(
            usuario: "João",
            fotoUsuario: "assets/teste.png",
            texto: "Massa!",
            curtidas: 1,
          ),
          CommentMock(
            usuario: "Carlinho",
            fotoUsuario: "assets/teste.png",
            texto: "Joga Muito!",
            curtidas: 2,
          ),
        ],
        tempoPost: '5h',
        isCurtido: false,
      ),
      FeedPost(
        usuario: 'Gabriel',
        fotoUsuario: "assets/teste.png",
        conteudo: 'Festa da vitória! 🏆🎉',
        imagem: null,
        curtidas: 102,
        comentarios: [
          CommentMock(
            usuario: "Maria",
            fotoUsuario: "assets/teste.png",
            texto: "Show!",
            curtidas: 3,
          ),
          CommentMock(
            usuario: "João",
            fotoUsuario: "assets/teste.png",
            texto: "Massa!",
            curtidas: 1,
          ),
          CommentMock(
            usuario: "Carlinho",
            fotoUsuario: "assets/teste.png",
            texto: "Joga Muito!",
            curtidas: 2,
          ),
        ],
        tempoPost: '9h',
        isCurtido: false,
      ),
    ];
    return Column(
      children: posts
          .map(
            (p) => FeedPost(
              usuario: p.usuario,
              fotoUsuario: p.fotoUsuario,
              conteudo: p.conteudo,
              imagem: p.imagem,
              curtidas: p.curtidas,
              comentarios: p.comentarios,
              tempoPost: p.tempoPost,
              isCurtido: p.isCurtido,
            ),
          )
          .toList(),
    );
  }
}
