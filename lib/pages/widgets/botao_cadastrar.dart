import 'package:flutter/material.dart';

class BotaoCadastrar extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final bool isMobile;

  const BotaoCadastrar({
    Key? key,
    required this.onPressed,
    this.label = 'CADASTRAR',
    this.icon = Icons.check_circle_outline,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00FF00),
          foregroundColor: Colors.black,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 22 : 26,
            letterSpacing: 1.1,
          ),
          minimumSize: const Size(0, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          elevation: 11,
        ),
        icon: Icon(icon, size: 32),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
