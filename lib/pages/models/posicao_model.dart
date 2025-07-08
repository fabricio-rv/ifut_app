import 'package:flutter/material.dart';

// models/posicao_model.dart
class PosicaoModel {
  final String nome;
  final String emoji;
  bool principal;
  bool secundaria;

  PosicaoModel({
    required this.nome,
    required this.emoji,
    this.principal = false,
    this.secundaria = false,
  });
}
