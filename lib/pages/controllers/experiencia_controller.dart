// controllers/experiencia_controller.dart
import 'package:flutter/material.dart';

class ExperienciaController extends ChangeNotifier {
  String? _experienciaSelecionada;

  String? get experienciaSelecionada => _experienciaSelecionada;

  void setExperiencia(String? experiencia) {
    _experienciaSelecionada = experiencia;
    notifyListeners();
  }
}
