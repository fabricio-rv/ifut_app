// lib/controllers/localizacao_controller.dart
import 'package:flutter/material.dart';

class LocalizacaoController extends ChangeNotifier {
  String nacionalidade = 'BRA';
  String? estado = 'RS';

  final TextEditingController cidadeCtrl = TextEditingController();
  final TextEditingController cepCtrl = TextEditingController();
  final TextEditingController bairroCtrl = TextEditingController();

  LocalizacaoController() {
    cidadeCtrl.addListener(() {
      cidade = cidadeCtrl.text;
      notifyListeners();
    });
    cepCtrl.addListener(() {
      cep = cepCtrl.text;
      notifyListeners();
    });
    bairroCtrl.addListener(() {
      bairro = bairroCtrl.text;
      notifyListeners();
    });
  }

  String cidade = '';
  String cep = '';
  String bairro = '';

  void setNacionalidade(String value) {
    nacionalidade = value;
    notifyListeners();
  }

  void setEstado(String? value) {
    estado = value;
    notifyListeners();
  }

  void setCidade(String value) {
    cidade = value;
    if (cidadeCtrl.text != value) cidadeCtrl.text = value;
    notifyListeners();
  }

  void setCep(String value) {
    cep = value;
    if (cepCtrl.text != value) cepCtrl.text = value;
    notifyListeners();
  }

  void setBairro(String value) {
    bairro = value;
    if (bairroCtrl.text != value) bairroCtrl.text = value;
    notifyListeners();
  }

  void limpar() {
    nacionalidade = 'BRA';
    estado = 'RS';
    cidade = '';
    cep = '';
    bairro = '';
    cidadeCtrl.clear();
    cepCtrl.clear();
    bairroCtrl.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    cidadeCtrl.dispose();
    cepCtrl.dispose();
    bairroCtrl.dispose();
    super.dispose();
  }
}
