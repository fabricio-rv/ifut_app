// widgets/campo_senha.dart

import 'package:flutter/material.dart';

class CampoSenha extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool mostrar;
  final VoidCallback onMostrar;
  final String? Function(String?)? validator;
  final String Function(String)? classificaForcaSenha;
  final Color Function(String)? corForcaSenha;
  final Function(String)? onChanged; // <-- NOVO

  const CampoSenha({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.mostrar,
    required this.onMostrar,
    this.validator,
    this.classificaForcaSenha,
    this.corForcaSenha,
    this.onChanged, // <-- NOVO
  });

  @override
  Widget build(BuildContext context) {
    final senha = controller.text;
    final forca = classificaForcaSenha?.call(senha) ?? '';
    final forcaCor = corForcaSenha?.call(senha) ?? Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TextFormField(
        controller: controller,
        obscureText: !mostrar,
        validator: validator,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        onChanged: (value) {
          // Atualiza provider/controller se precisar
          if (onChanged != null) onChanged!(value);
          // Força rebuild do helperText (força da senha)
          (context as Element).markNeedsBuild();
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF00FF00)),
          labelText: label,
          hintText: label == "Senha"
              ? "Digite sua senha"
              : "Confirme sua senha",
          labelStyle: const TextStyle(
            color: Color(0xFF00FF00),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          filled: true,
          fillColor: Colors.black,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 22,
            horizontal: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 1.8),
            borderRadius: BorderRadius.circular(11),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2.6),
            borderRadius: BorderRadius.circular(14),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
            borderRadius: BorderRadius.circular(11),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
            borderRadius: BorderRadius.circular(14),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              mostrar ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF00FF00),
            ),
            onPressed: onMostrar,
          ),
          helperText: senha.isNotEmpty ? 'Senha: $forca' : null,
          helperStyle: TextStyle(color: forcaCor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
