import 'package:flutter/material.dart';

class HomeMenuCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool small;

  const HomeMenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.small = false,
    super.key,
  });

  @override
  _HomeMenuCardState createState() => _HomeMenuCardState();
}

class _HomeMenuCardState extends State<HomeMenuCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          height: widget.small ? size.height * 0.12 : size.height * 0.18,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.60),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.greenAccent.withOpacity(0.1)),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.small ? 16 : 16,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: widget.small ? 4 : 6),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: widget.small ? 9 : 10,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  widget.icon,
                  color: Colors.greenAccent.withOpacity(0.7),
                  size: widget.small ? 75 : 75,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
