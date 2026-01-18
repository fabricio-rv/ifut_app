import 'package:flutter/material.dart';

// --- MOCK DE COMENTÁRIO ---
class CommentMock {
  final String usuario;
  final String fotoUsuario;
  final String texto;
  final int curtidas;
  final List<CommentMock> respostas;

  CommentMock({
    required this.usuario,
    required this.fotoUsuario,
    required this.texto,
    required this.curtidas,
    List<CommentMock>? respostas, // aceita null
  }) : respostas = respostas ?? []; // <-- se null vira lista vazia

  CommentMock copyWith({
    String? usuario,
    String? fotoUsuario,
    String? texto,
    int? curtidas,
    List<CommentMock>? respostas,
  }) {
    return CommentMock(
      usuario: usuario ?? this.usuario,
      fotoUsuario: fotoUsuario ?? this.fotoUsuario,
      texto: texto ?? this.texto,
      curtidas: curtidas ?? this.curtidas,
      respostas: respostas ?? this.respostas,
    );
  }
}

// --- FEED POST ---
class FeedPost extends StatefulWidget {
  final String usuario;
  final String fotoUsuario;
  final String conteudo;
  final String? imagem;
  final int curtidas;
  final String tempoPost;
  final bool isCurtido;
  final List<CommentMock> comentarios; // <-- Adicione este parâmetro!

  const FeedPost({
    super.key,
    required this.usuario,
    required this.fotoUsuario,
    required this.conteudo,
    this.imagem,
    required this.curtidas,
    required this.tempoPost,
    this.isCurtido = false,
    required this.comentarios, // <-- E aqui!
  });

  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  late bool curtido;
  late int curtidas;
  late List<CommentMock> comentarios;

  @override
  void initState() {
    super.initState();
    curtido = widget.isCurtido;
    curtidas = widget.curtidas;
    comentarios = List<CommentMock>.from(
      widget.comentarios,
    ); // <-- Inicializa aqui!
  }

  void toggleCurtida() {
    setState(() {
      curtido = !curtido;
      curtido ? curtidas++ : curtidas--;
    });
  }

  void abrirModalComentarios() async {
    final novosComentarios = await showModalBottomSheet<List<CommentMock>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (ctx) {
        return ComentariosModal(
          comentarios: List<CommentMock>.from(comentarios),
        );
      },
    );
    if (novosComentarios != null) {
      setState(() => comentarios = novosComentarios);
    }
  }

  void abrirModalEnviar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text(
          'Enviar para...',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Funcionalidade mock: Escolher usuário para enviar o post!',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Fechar',
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }

  void abrirModalCompartilhar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text(
          'Compartilhar',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Funcionalidade mock: Compartilhar post (simulado).',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Fechar',
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textoComentarioStyle = TextStyle(
      color: Colors.white.withOpacity(0.93),
      fontSize: 14,
    );
    final textoMenor = TextStyle(color: Colors.white60, fontSize: 16);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Usuário + tempo + menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: widget.fotoUsuario.startsWith('http')
                    ? NetworkImage(widget.fotoUsuario)
                    : AssetImage(widget.fotoUsuario) as ImageProvider,
                radius: 21,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.usuario,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(widget.tempoPost, style: textoMenor),
              const SizedBox(width: 6),
              Icon(Icons.more_vert, color: Colors.greenAccent, size: 26),
            ],
          ),
          const SizedBox(height: 8),
          // Conteúdo texto
          Padding(
            padding: const EdgeInsets.only(left: 6.0, right: 10.0),
            child: Text(
              widget.conteudo,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Imagem/video do post
          if (widget.imagem != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.imagem!.startsWith('http')
                  ? Image.network(
                      widget.imagem!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 210,
                      errorBuilder: (_, __, ___) =>
                          Container(height: 210, color: Colors.grey[900]),
                    )
                  : Image.asset(
                      widget.imagem!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                      errorBuilder: (_, __, ___) =>
                          Container(height: 210, color: Colors.grey[900]),
                    ),
            ),
          ],
          const SizedBox(height: 6),
          // --- Linha de ações ---
          Padding(
            padding: const EdgeInsets.only(
              left: 0,
              right: 0,
            ), // bem próximo da borda esquerda!
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    curtido ? Icons.favorite : Icons.favorite_border,
                    color: Colors.greenAccent,
                    size: 26,
                  ),
                  onPressed: toggleCurtida,
                  splashRadius: 20,
                ),
                const SizedBox(width: 2), // bem pequeno
                Text('$curtidas', style: textoMenor),
                const SizedBox(width: 6),
                IconButton(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.greenAccent,
                    size: 26,
                  ),
                  onPressed: abrirModalComentarios,
                  splashRadius: 20,
                ),
                const SizedBox(width: 2),
                Text('${comentarios.length}', style: textoMenor),
                const SizedBox(width: 6),
                IconButton(
                  icon: Transform.rotate(
                    angle: -0.50,
                    child: Icon(
                      Icons.send,
                      color: Colors.greenAccent,
                      size: 26,
                    ),
                  ),
                  onPressed: abrirModalEnviar,
                  splashRadius: 20,
                ),
                Expanded(child: Container()), // compartilhar vai pra direita
                Container(
                  width: 38, // diminua esse valor (ex: 28 ou 30)
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 23,
                    ),
                    onPressed: abrirModalCompartilhar,
                    splashRadius: 22,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // Comentários (até 3)
          ...comentarios
              .take(2)
              .map(
                (coment) => Padding(
                  padding: const EdgeInsets.only(
                    left: 12, // Mais colado na esquerda
                    right: 10,
                    bottom: 10, // Mais afastado na vertical
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: coment.fotoUsuario.startsWith('http')
                            ? NetworkImage(coment.fotoUsuario)
                            : AssetImage(coment.fotoUsuario) as ImageProvider,
                        radius: 13,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${coment.usuario}: ${coment.texto}',
                          style: textoComentarioStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),
                ),
              ),
          if (comentarios.length > 2)
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 0,
                bottom: 8,
              ), // alinhado com comentário
              child: GestureDetector(
                onTap: abrirModalComentarios,
                child: const Text(
                  'Ver todos os comentários',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                ),
              ),
            ),
          const Divider(color: Colors.white10, thickness: 1, height: 20),
        ],
      ),
    );
  }
}

// --- MODAL DE COMENTÁRIOS ---
class ComentariosModal extends StatefulWidget {
  final List<CommentMock> comentarios;

  const ComentariosModal({super.key, required this.comentarios});

  @override
  State<ComentariosModal> createState() => _ComentariosModalState();
}

class _ComentariosModalState extends State<ComentariosModal> {
  late List<CommentMock> comentarios;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    comentarios = List<CommentMock>.from(widget.comentarios);
  }

  void adicionarComentario(String texto, [List<CommentMock>? onde]) {
    if (texto.trim().isEmpty) return;
    final novoComentario = CommentMock(
      usuario: "Você",
      fotoUsuario: "assets/teste.png",
      texto: texto,
      curtidas: 0,
    );
    setState(() {
      if (onde == null) {
        comentarios.add(novoComentario);
      } else {
        onde.add(novoComentario);
      }
      controller.clear();
    });
  }

  void deletarComentario(List<CommentMock> lista, int idx) {
    setState(() {
      lista.removeAt(idx);
    });
  }

  void curtirComentario(List<CommentMock> lista, int idx) {
    setState(() {
      final coment = lista[idx];
      lista[idx] = coment.copyWith(curtidas: coment.curtidas + 1);
    });
  }

  void abrirModalResponderComentario(
    BuildContext context,
    List<CommentMock> respostas,
  ) async {
    final respostaController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text("Responder", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: respostaController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Digite sua resposta...",
            hintStyle: TextStyle(color: Colors.white60),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (respostaController.text.trim().isNotEmpty) {
                adicionarComentario(respostaController.text, respostas);
              }
              Navigator.pop(ctx);
            },
            child: const Text(
              'Responder',
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComentario(
    CommentMock coment,
    List<CommentMock> parentList,
    int idx, {
    int level = 0,
  }) {
    final textoComentarioStyle = TextStyle(
      color: Colors.white.withOpacity(0.93),
      fontSize: 14,
    );
    return Padding(
      padding: EdgeInsets.only(left: 16.0 * level, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: coment.fotoUsuario.startsWith('http')
                    ? NetworkImage(coment.fotoUsuario)
                    : AssetImage(coment.fotoUsuario) as ImageProvider,
                radius: 16,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${coment.usuario}: ',
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: coment.texto,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.greenAccent,
                  size: 22,
                ),
                onPressed: () => curtirComentario(parentList, idx),
              ),
              Text(
                coment.curtidas > 0 ? "${coment.curtidas}" : "",
                style: const TextStyle(color: Colors.greenAccent, fontSize: 13),
              ),
              IconButton(
                icon: const Icon(
                  Icons.mode_comment_outlined,
                  color: Colors.greenAccent,
                  size: 21,
                ),
                onPressed: () =>
                    abrirModalResponderComentario(context, coment.respostas),
                tooltip: 'Comentar',
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 22,
                ),
                onPressed: () => deletarComentario(parentList, idx),
              ),
            ],
          ),
          // Subcomentários recursivos:
          ...coment.respostas.asMap().entries.map(
            (entry) => Padding(
              padding: EdgeInsets.only(
                left:
                    24.0 *
                    (level + 1), // indentação crescente para subcomentários
                bottom: 10, // mais espaço entre eles
              ),
              child: buildComentario(
                entry.value,
                coment.respostas,
                entry.key,
                level: level + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 52,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: comentarios.length,
                itemBuilder: (ctx, i) {
                  return buildComentario(comentarios[i], comentarios, i);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Adicionar comentário...",
                      hintStyle: const TextStyle(color: Colors.white60),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white12,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.greenAccent, size: 26),
                  onPressed: () => adicionarComentario(controller.text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
