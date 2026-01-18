import 'package:flutter/material.dart';

class CaracteristicasFisicasController extends ChangeNotifier {
  final alturaCtrl = TextEditingController();
  final pesoCtrl = TextEditingController();
  String peDominante = '';

  String get altura => alturaCtrl.text;
  set altura(String v) {
    alturaCtrl.text = v;
    notifyListeners();
  }

  String get peso => pesoCtrl.text;
  set peso(String v) {
    pesoCtrl.text = v;
    notifyListeners();
  }

  void setAltura(String value) {
    altura = value;
  }

  void setPeso(String value) {
    peso = value;
  }

  void setPeDominante(String value) {
    peDominante = value;
    notifyListeners();
  }

  void limpar() {
    alturaCtrl.clear();
    pesoCtrl.clear();
    peDominante = '';
    notifyListeners();
  }

  @override
  void dispose() {
    alturaCtrl.dispose();
    pesoCtrl.dispose();
    super.dispose();
  }
}
