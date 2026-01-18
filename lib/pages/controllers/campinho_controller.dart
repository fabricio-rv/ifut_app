// controllers/campinho_controller.dart
import 'package:flutter/material.dart';
import '../models/posicao_model.dart';

class CampinhoController extends ChangeNotifier {
  String? principal;
  Set<String> secundarias = {};

  void selecionarPosicao(String nome) {
    if (principal == nome) {
      // Se já é principal, desmarca
      principal = null;
      notifyListeners();
      return;
    }
    if (secundarias.contains(nome)) {
      // Se estava como secundária e clicou: promove para principal, removendo de secundária
      secundarias.remove(nome);
      principal = nome;
      notifyListeners();
      return;
    }
    if (principal == null) {
      // Nenhuma principal, vira principal direto
      principal = nome;
      notifyListeners();
      return;
    }
    // Se já tem principal e clica em uma outra posição: marca/desmarca como secundária (não pode ser principal)
    if (!secundarias.contains(nome)) {
      secundarias.add(nome);
    } else {
      secundarias.remove(nome);
    }
    notifyListeners();
  }
}
