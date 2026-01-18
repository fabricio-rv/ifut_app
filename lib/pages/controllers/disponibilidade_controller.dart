// controllers/disponibilidade_controller.dart
import 'package:flutter/material.dart';

class DisponibilidadeController extends ChangeNotifier {
  String? _disponibilidadeSelecionada;

  String? get disponibilidadeSelecionada => _disponibilidadeSelecionada;

  void setDisponibilidade(String? disponibilidade) {
    _disponibilidadeSelecionada = disponibilidade;
    notifyListeners();
  }
}
