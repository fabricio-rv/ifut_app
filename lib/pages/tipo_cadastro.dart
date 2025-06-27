// tipo_cadastro.dart
import 'package:flutter/material.dart';

class TipoCadastroPage extends StatelessWidget {
  const TipoCadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/fundo_estadio.png", fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.80)),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 8 : 40,
                vertical: isMobile ? 10 : 28,
              ),
              child: Column(
                children: [
                  SizedBox(height: isMobile ? 12 : 18),
                  Text(
                    'ESCOLHA SEU MODO',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.87),
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 30 : 50,
                      letterSpacing: 2.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 8 : 8),
                  // Cards maiores, mais próximos do título
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _TipoCardCustom(
                          isMobile: isMobile,
                          title: 'JOGADOR',
                          backgroundImage: "assets/jogador_fundo.png",
                          borderColor: Colors.white.withOpacity(0.10),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/cadastro_jogador',
                            arguments: "jogador",
                          ),
                        ),
                        _TipoCardCustom(
                          isMobile: isMobile,
                          title: 'TÉCNICO',
                          backgroundImage: "assets/tecnico_fundo.png",
                          borderColor: Colors.white.withOpacity(0.10),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/cadastro_tecnico',
                            arguments: "tecnico",
                          ),
                        ),
                        _TipoCardCustom(
                          isMobile: isMobile,
                          title: 'TORCEDOR',
                          backgroundImage: "assets/torcedor_fundo.png",
                          borderColor: Colors.white.withOpacity(0.10),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/cadastro_torcedor',
                            arguments: "torcedor",
                          ),
                        ),
                        SizedBox(height: isMobile ? 8 : 14),
                        // Botões Tutorial e Voltar
                        _CustomNeonButton(
                          text: 'Tutorial',
                          filled: true,
                          onTap: () =>
                              Navigator.pushNamed(context, '/tutorial'),
                          fontSize: isMobile ? 18 : 26,
                          icon: Icons.school,
                          backgroundColor: const Color(0xFF00FF00),
                          textColor: Colors.black,
                        ),
                        SizedBox(height: 10),
                        _CustomNeonButton(
                          text: 'Voltar',
                          filled: false,
                          onTap: () => Navigator.pop(context),
                          fontSize: isMobile ? 18 : 26,
                          icon: Icons.arrow_back,
                          backgroundColor: const Color(0xFF252525),
                          textColor: Colors.white,
                        ),
                        SizedBox(height: isMobile ? 12 : 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipoCardCustom extends StatefulWidget {
  final String title;
  final String backgroundImage;
  final VoidCallback onTap;
  final bool isMobile;
  final Color borderColor;

  const _TipoCardCustom({
    required this.title,
    required this.backgroundImage,
    required this.onTap,
    required this.isMobile,
    required this.borderColor,
  });

  @override
  State<_TipoCardCustom> createState() => _TipoCardCustomState();
}

class _TipoCardCustomState extends State<_TipoCardCustom>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 80),
      lowerBound: 0.96,
      upperBound: 1.0,
      vsync: this,
      value: 1.0,
    );
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails d) => _controller.reverse();
  void _onTapUp(TapUpDetails d) => _controller.forward();
  void _onTapCancel() => _controller.forward();

  @override
  Widget build(BuildContext context) {
    final double height = widget.isMobile ? 258 : 362; // maior!
    final double radius = 32.0;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: height,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: widget.borderColor, width: 1.6),
            image: DecorationImage(
              image: AssetImage(widget.backgroundImage),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.10),
                BlendMode.darken,
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget.isMobile ? 18 : 24,
                left: widget.isMobile ? 12 : 30,
                right: widget.isMobile ? 12 : 30,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.73),
                  fontSize: widget.isMobile ? 25 : 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomNeonButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool filled;
  final double fontSize;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;

  const _CustomNeonButton({
    required this.text,
    required this.onTap,
    required this.filled,
    required this.fontSize,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: fontSize + 3),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
