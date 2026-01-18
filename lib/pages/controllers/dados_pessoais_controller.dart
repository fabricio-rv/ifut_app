import 'package:flutter/material.dart';
import 'calendario_controller.dart'; // importe seu calendario controller aqui

class DadosPessoaisController extends ChangeNotifier {
  final nomeCtrl = TextEditingController();
  final apelidoCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final telefoneCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();
  final confirmarSenhaCtrl = TextEditingController();
  final dataNascimentoCtrl = TextEditingController();

  final CalendarioController calendarioController = CalendarioController();

  String get nome => nomeCtrl.text;
  set nome(String v) {
    nomeCtrl.text = v;
    notifyListeners();
  }

  String get apelido => apelidoCtrl.text;
  set apelido(String v) {
    apelidoCtrl.text = v;
    notifyListeners();
  }

  String get email => emailCtrl.text;
  set email(String v) {
    emailCtrl.text = v;
    notifyListeners();
  }

  String get telefone => telefoneCtrl.text;
  set telefone(String v) {
    telefoneCtrl.text = v;
    notifyListeners();
  }

  String get senha => senhaCtrl.text;
  set senha(String v) {
    senhaCtrl.text = v;
    notifyListeners();
  }

  String get confirmarSenha => confirmarSenhaCtrl.text;
  set confirmarSenha(String v) {
    confirmarSenhaCtrl.text = v;
    notifyListeners();
  }

  String get dataNascimento => dataNascimentoCtrl.text;
  set dataNascimento(String v) {
    dataNascimentoCtrl.text = v;
    notifyListeners();
  }

  void setNome(String value) {
    nome = value;
  }

  void setApelido(String value) {
    apelido = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setTelefone(String value) {
    telefone = value;
  }

  void setSenha(String value) {
    senha = value;
  }

  void setConfirmarSenha(String value) {
    confirmarSenha = value;
  }

  // Método para setar a dataNascimento e atualizar o controller
  void setDataNascimento(String value) {
    dataNascimento = value;
    dataNascimentoCtrl.text = value;
    notifyListeners();
  }

  void limpar() {
    nomeCtrl.clear();
    apelidoCtrl.clear();
    emailCtrl.clear();
    telefoneCtrl.clear();
    senhaCtrl.clear();
    confirmarSenhaCtrl.clear();
    calendarioController.limpar();
    notifyListeners();
  }

  @override
  void dispose() {
    nomeCtrl.dispose();
    apelidoCtrl.dispose();
    emailCtrl.dispose();
    telefoneCtrl.dispose();
    senhaCtrl.dispose();
    confirmarSenhaCtrl.dispose();
    calendarioController.dispose();
    super.dispose();
  }
}
