import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController senhaCtrl = TextEditingController();

  bool senhaVisivel = false;

  void setEmail(String value) {
    notifyListeners();
  }

  void setSenha(String value) {
    notifyListeners();
  }

  void toggleSenhaVisivel() {
    senhaVisivel = !senhaVisivel;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe o email';
    final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    if (!emailRegex.hasMatch(value)) return 'Email inválido';
    return null;
  }

  String? validateSenha(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 6) return 'Senha deve ter ao menos 6 caracteres';
    return null;
  }

  Future<bool> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;

    final email = emailCtrl.text.trim();
    final senha = senhaCtrl.text;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: senha,
      );

      Navigator.of(context).pop();

      if (response.session != null) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email ou senha inválidos')),
        );
        return false;
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao fazer login: $e')));
      return false;
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    senhaCtrl.dispose();
    super.dispose();
  }
}
