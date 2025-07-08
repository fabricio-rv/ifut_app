// lib/controllers/tecnico_controller.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TecnicoController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final nomeCtrl = TextEditingController();
  final apelidoCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();
  final confirmarSenhaCtrl = TextEditingController();
  String? fotoPerfil;
  String? nacionalidade = 'BRA';
  String? estado = 'RS';
  DateTime? dataNascimento;
  final cidadeCtrl = TextEditingController();
  final bairroCtrl = TextEditingController();
  final cepCtrl = TextEditingController();
  final dataNascimentoCtrl = TextEditingController();

  String? experienciaSelecionada;
  String? disponibilidadeSelecionada;
  List<String> niveisQueTreina = [];
  List<String> estilosTaticos = [];

  bool validando = false;

  TecnicoController() {
    nomeCtrl.addListener(() => notifyListeners());
    apelidoCtrl.addListener(() => notifyListeners());
    emailCtrl.addListener(() => notifyListeners());
    senhaCtrl.addListener(() => notifyListeners());
    confirmarSenhaCtrl.addListener(() => notifyListeners());
    cidadeCtrl.addListener(() => notifyListeners());
    bairroCtrl.addListener(() => notifyListeners());
    cepCtrl.addListener(() => notifyListeners());
  }

  void setDataNascimento(DateTime? value) {
    dataNascimento = value;
    if (value != null) {
      dataNascimentoCtrl.text =
          "${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}";
    } else {
      dataNascimentoCtrl.text = '';
    }
    notifyListeners();
  }

  void setFotoPerfil(String? v) {
    fotoPerfil = v;
    notifyListeners();
  }

  void setNacionalidade(String? v) {
    nacionalidade = v;
    notifyListeners();
  }

  void setEstado(String? v) {
    estado = v;
    notifyListeners();
  }

  void setExperiencia(String? v) {
    experienciaSelecionada = v;
    notifyListeners();
  }

  void setDisponibilidade(String? v) {
    disponibilidadeSelecionada = v;
    notifyListeners();
  }

  void setNiveisQueTreina(List<String> v) {
    niveisQueTreina = v;
    notifyListeners();
  }

  void setEstilosTaticos(List<String> v) {
    estilosTaticos = v;
    notifyListeners();
  }

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

  void setCep(String val) {
    cepCtrl.text = val;
    notifyListeners();
  }

  void setBairro(String val) {
    bairroCtrl.text = val;
    notifyListeners();
  }

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

      // 2. Insere em usuarios (com tipo TECNICO)
      await supabase.from('usuarios').insert({
        'id_usuario': idUsuario,
        'nome': nomeCtrl.text.trim(),
        'apelido': apelidoCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'tipo': 'TECNICO',
      });

      // 3. Insere em perfil_tecnico
      await supabase.from('perfil_tecnico').insert({
        'id_usuario': idUsuario,
        'foto_perfil': fotoPerfil,
        'data_nascimento': dataNascimento != null
            ? DateFormat('yyyy-MM-dd').format(dataNascimento!)
            : null,
        'experiencia': experienciaSelecionada,
        'disponibilidade': disponibilidadeSelecionada,
        'niveis_treinados': niveisQueTreina.isNotEmpty
            ? niveisQueTreina.join(',')
            : null,
        'estilo_tatico': estilosTaticos.isNotEmpty
            ? estilosTaticos.join(',')
            : null,
      });

      // 4. Insere em localizacao_usuario
      await supabase.from('localizacao_usuario').insert({
        'id_usuario': idUsuario,
        'nacionalidade': nacionalidade ?? 'BRA',
        'estado': estado ?? 'RS',
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
    }
  }

  void limpar() {
    nomeCtrl.clear();
    apelidoCtrl.clear();
    emailCtrl.clear();
    senhaCtrl.clear();
    confirmarSenhaCtrl.clear();
    cidadeCtrl.clear();
    bairroCtrl.clear();
    cepCtrl.clear();
    fotoPerfil = null;
    nacionalidade = 'BRA';
    estado = null;
    experienciaSelecionada = null;
    disponibilidadeSelecionada = null;
    niveisQueTreina = [];
    estilosTaticos = [];
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
    cidadeCtrl.dispose();
    bairroCtrl.dispose();
    cepCtrl.dispose();
    super.dispose();
  }
}
