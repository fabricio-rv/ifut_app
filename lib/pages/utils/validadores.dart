// lib/utils/validadores.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Validadores {
  static String? validaNome(String? v) {
    if (v == null || v.trim().isEmpty) return "Campo obrigatório";
    final partes = v.trim().split(' ');
    if (partes.length < 2) return "Digite nome e sobrenome";
    if (partes.any((p) => p.length < 2)) return "Nome inválido";
    return null;
  }

  static String? validaApelido(String? v) {
    if (v == null || v.trim().isEmpty) return "Campo obrigatório";
    return null;
  }

  static String? validaEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe o email';
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  static String? validaTelefone(String? v) {
    if (v == null || v.trim().isEmpty) return "Campo obrigatório";
    final rgx = RegExp(r'^\(\d{2}\)\s?\d{5}-\d{4}$');
    if (!rgx.hasMatch(v)) return "Ex: (11) 91234-5678";
    return null;
  }

  static String? validaNascimento(String? v) {
    if (v == null || v.trim().isEmpty) return "Campo obrigatório";
    try {
      final parts = v.split('/');
      if (parts.length != 3) return "Formato dd/mm/aaaa";
      final d = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      final y = int.parse(parts[2]);
      final dt = DateTime(y, m, d);
      if (dt.isAfter(DateTime.now())) return "Data não pode ser futura";
      if (d < 1 || d > 31 || m < 1 || m > 12 || y < 1900)
        return "Data inválida";
      return null;
    } catch (e) {
      return "Formato dd/mm/aaaa";
    }
  }

  static bool forcaSenha(String senha) {
    if (senha.length < 8) return false;
    bool temLetra = senha.contains(RegExp(r'[A-Za-z]'));
    bool temNumero = senha.contains(RegExp(r'\d'));
    return temLetra && temNumero;
  }

  static String classificaForcaSenha(String senha) {
    if (senha.length < 8) return "Muito fraca";
    bool letra = senha.contains(RegExp(r'[A-Za-z]'));
    bool numero = senha.contains(RegExp(r'\d'));
    bool simbolo = senha.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
    if (letra && numero && simbolo && senha.length >= 12) return "Forte";
    if (letra && numero) return "Média";
    return "Fraca";
  }

  static Color corForcaSenha(String senha) {
    switch (classificaForcaSenha(senha)) {
      case "Forte":
        return Colors.green;
      case "Média":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  static String? validaSenha(String? v) {
    if (v == null || v.isEmpty) return "Campo obrigatório";
    if (!forcaSenha(v)) return "Senha deve ser média ou forte";
    return null;
  }

  static String? validaConfirmarSenha(String? v, String senhaOriginal) {
    if (v == null || v.isEmpty) return "Campo obrigatório";
    if (!forcaSenha(v)) return "Senha deve ser média ou forte";
    if (v != senhaOriginal) return "Senhas não conferem";
    return null;
  }

  static String? validaAltura(String? v) {
    if (v == null || v.isEmpty) return "Campo obrigatório";
    final n = int.tryParse(v);
    if (n == null || n < 140 || n > 220) return "Altura entre 140 e 220 cm";
    return null;
  }

  static String? validaPeso(String? v) {
    if (v == null || v.isEmpty) return "Campo obrigatório";
    final n = double.tryParse(v.replaceAll(',', '.'));
    if (n == null || n < 40 || n > 180) return "Peso entre 40 e 180 kg";
    return null;
  }

  static String? validaCampoObrigatorio(String? v) {
    if (v == null || v.trim().isEmpty) return "Campo obrigatório";
    return null;
  }
}
