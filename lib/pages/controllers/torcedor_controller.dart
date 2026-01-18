// lib/controllers/torcedor_controller.dart
// controllers/torcedor_controller.dart
import 'package:flutter/material.dart';
import '../utils/validadores.dart';
import '../models/cadastro_torcedor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class TorcedorController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final nomeCtrl = TextEditingController();
  final apelidoCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();
  final confirmarSenhaCtrl = TextEditingController();
  final cidadeCtrl = TextEditingController();
  final bairroCtrl = TextEditingController();
  final cepCtrl = TextEditingController();
  final dataNascimentoCtrl = TextEditingController();

  String? estado;
  String? nacionalidade = 'BRA';
  String? timeCoracao;

  bool mostrarSenha = false;
  bool mostrarConfirmarSenha = false;
  bool validando = false;

  Map<String, bool> notificacoes = {
    "Jogos próximos": false,
    "Promoções/sorteios": false,
    "Atualizações do app": false,
  };

  // Setters para campos de texto com notifyListeners
  void setNome(String val) {
    nomeCtrl.text = val;
    notifyListeners();
  }

  void setApelido(String val) {
    apelidoCtrl.text = val;
    notifyListeners();
  }

  void setEmail(String val) {
    emailCtrl.text = val;
    notifyListeners();
  }

  void setSenha(String val) {
    senhaCtrl.text = val;
    notifyListeners();
  }

  void setConfirmarSenha(String val) {
    confirmarSenhaCtrl.text = val;
    notifyListeners();
  }

  void setCidade(String val) {
    cidadeCtrl.text = val;
    notifyListeners();
  }

  void setBairro(String val) {
    bairroCtrl.text = val;
    notifyListeners();
  }

  void setCep(String val) {
    cepCtrl.text = val;
    notifyListeners();
  }

  void setDataNascimento(String val) {
    dataNascimentoCtrl.text = val;
    notifyListeners();
  }

  void setEstado(String? val) {
    estado = val;
    notifyListeners();
  }

  void setNacionalidade(String? val) {
    nacionalidade = val;
    notifyListeners();
  }

  void setTimeCoracao(String? val) {
    timeCoracao = val;
    notifyListeners();
  }

  void setNotificacao(String key, bool val) {
    notificacoes[key] = val;
    notifyListeners();
  }

  // Validadores que chamam Validadores externos
  String? validarNome(String? v) => Validadores.validaNome(v);
  String? validarApelido(String? v) => Validadores.validaApelido(v);
  String? validarEmail(String? v) => Validadores.validaEmail(v);
  String? validarSenha(String? v) => Validadores.validaSenha(v);
  String? validarConfirmarSenha(String? v) =>
      Validadores.validaConfirmarSenha(v, senhaCtrl.text);
  String? validarCidade(String? v) => Validadores.validaCampoObrigatorio(v);
  String? validarDataNascimento(String? v) => Validadores.validaNascimento(v);

  Future<void> cadastrar(BuildContext context) async {
    validando = true;
    notifyListeners();

    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos obrigatórios corretamente!"),
          backgroundColor: Colors.red,
        ),
      );
      validando = false;
      notifyListeners();
      return;
    }

    try {
      final supabase = Supabase.instance.client;

      // 1. Cadastra no Auth
      final authRes = await supabase.auth.signUp(
        email: emailCtrl.text.trim().toLowerCase(),
        password: senhaCtrl.text,
      );

      final user = authRes.user;
      if (user == null) {
        throw Exception('Erro ao criar conta de usuário (Auth)');
      }
      final String idUsuario = user.id;

      // 2. Insere em usuarios (com tipo TORCEDOR)
      await supabase.from('usuarios').insert({
        'id_usuario': idUsuario,
        'nome': nomeCtrl.text.trim(),
        'apelido': apelidoCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'tipo': 'TORCEDOR',
      });

      // 3. Insere em perfil_torcedor
      await supabase.from('perfil_torcedor').insert({
        'id_usuario': idUsuario,
        'data_nascimento': dataNascimentoCtrl.text.trim().isNotEmpty
            ? DateFormat('yyyy-MM-dd').format(
                DateFormat('dd/MM/yyyy').parse(dataNascimentoCtrl.text.trim()),
              )
            : null,
        'time_coracao': timeCoracao,
        'preferencias_notificacao': notificacoes.entries
            .where((e) => e.value)
            .map((e) => e.key)
            .join(','), // ou outro formato que esteja no banco
      });

      // 4. Insere em localizacao_usuario
      await supabase.from('localizacao_usuario').insert({
        'id_usuario': idUsuario,
        'nacionalidade': nacionalidade ?? 'BRA',
        'estado': estado,
        'cidade': cidadeCtrl.text.trim(),
        'bairro': bairroCtrl.text.trim(),
        'cep': cepCtrl.text.trim(),
      });

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cadastro realizado com sucesso!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/');
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro Auth: ${e.message}"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
    } finally {
      validando = false;
      notifyListeners();
    }
  }

  // Outros métodos (limpar, dispose) permanecem iguais...

  // Limpar campos
  void limpar() {
    nomeCtrl.clear();
    apelidoCtrl.clear();
    emailCtrl.clear();
    senhaCtrl.clear();
    confirmarSenhaCtrl.clear();
    dataNascimentoCtrl.clear();
    cidadeCtrl.clear();
    bairroCtrl.clear();
    cepCtrl.clear();

    estado = null;
    nacionalidade = 'BRA';
    timeCoracao = null;
    notificacoes = {
      "Jogos próximos": false,
      "Promoções/sorteios": false,
      "Atualizações do app": false,
    };

    mostrarSenha = false;
    mostrarConfirmarSenha = false;
    validando = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nomeCtrl.dispose();
    apelidoCtrl.dispose();
    emailCtrl.dispose();
    senhaCtrl.dispose();
    confirmarSenhaCtrl.dispose();
    dataNascimentoCtrl.dispose();
    cidadeCtrl.dispose();
    bairroCtrl.dispose();
    cepCtrl.dispose();
    super.dispose();
  }
}
