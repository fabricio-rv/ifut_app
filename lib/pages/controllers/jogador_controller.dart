import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JogadorController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  // Dados Pessoais
  String nome = '';
  String apelido = '';
  String email = '';
  String senha = '';
  String confirmarSenha = '';
  String dataNascimento = '';

  // Características físicas
  String? altura;
  String? peso;
  String? peDominante;

  // Localização
  String? nacionalidade;
  String? estado;
  String cidade = '';
  String bairro = '';
  String cep = '';

  // Jogo
  Set<String> niveis = {};
  String? posicaoPrincipal;
  Set<String> posicoesSecundarias = {};
  Set<String> badgesSelecionadas = {};

  bool validando = false;
  bool mostrarSenha = false;
  bool mostrarConfSenha = false;

  // Setters
  void setNome(String val) {
    nome = val;
    notifyListeners();
  }

  void setApelido(String val) {
    apelido = val;
    notifyListeners();
  }

  void setEmail(String val) {
    email = val;
    notifyListeners();
  }

  void setSenha(String val) {
    senha = val;
    notifyListeners();
  }

  void setConfirmarSenha(String val) {
    confirmarSenha = val;
    notifyListeners();
  }

  void setDataNascimento(String val) {
    dataNascimento = val;
    notifyListeners();
  }

  void setAltura(String? val) {
    altura = val;
    notifyListeners();
  }

  void setPeso(String? val) {
    peso = val;
    notifyListeners();
  }

  void setPeDominante(String? val) {
    peDominante = val;
    notifyListeners();
  }

  void setNacionalidade(String? val) {
    nacionalidade = val;
    notifyListeners();
  }

  void setEstado(String? val) {
    estado = val;
    notifyListeners();
  }

  void setCidade(String val) {
    cidade = val;
    notifyListeners();
  }

  void setBairro(String val) {
    bairro = val;
    notifyListeners();
  }

  void setCep(String val) {
    cep = val;
    notifyListeners();
  }

  void setNiveis(Set<String> val) {
    niveis = val;
    notifyListeners();
  }

  void setPosicaoPrincipal(String? val) {
    posicaoPrincipal = val;
    notifyListeners();
  }

  void setPosicoesSecundarias(Set<String> val) {
    posicoesSecundarias = val;
    notifyListeners();
  }

  void setBadgesSelecionadas(Set<String> val) {
    badgesSelecionadas = val;
    notifyListeners();
  }

  void toggleMostrarSenha() {
    mostrarSenha = !mostrarSenha;
    notifyListeners();
  }

  void toggleMostrarConfSenha() {
    mostrarConfSenha = !mostrarConfSenha;
    notifyListeners();
  }

  /// Cadastro multi-tabela alinhado com banco atual
  Future<void> cadastrar(BuildContext context) async {
    validando = true;
    notifyListeners();

    if (formKey.currentState?.validate() != true ||
        niveis.isEmpty ||
        posicaoPrincipal == null ||
        posicaoPrincipal!.isEmpty ||
        peDominante == null ||
        peDominante!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios corretamente!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final supabase = Supabase.instance.client;

      // 1. Cadastra no Auth
      final authRes = await supabase.auth.signUp(
        email: email.trim().toLowerCase(),
        password: senha,
      );

      final user = authRes.user;
      if (user == null) {
        throw Exception('Erro ao criar conta de usuário (Auth)');
      }

      final String idUsuario = user.id; // UUID do Auth

      // 2. Insere em usuarios (usando mesmo id do Auth)
      await supabase.from('usuarios').insert({
        'id_usuario': idUsuario,
        'nome': nome,
        'apelido': apelido,
        'email': email.trim().toLowerCase(),
        'tipo': 'JOGADOR',
      });

      // 3. Insere em perfil_jogador
      await supabase.from('perfil_jogador').insert({
        'id_usuario': idUsuario,
        'foto_perfil': null,
        'data_nascimento': dataNascimento.isNotEmpty
            ? DateFormat(
                'dd/MM/yyyy',
              ).parse(dataNascimento).toIso8601String().substring(0, 10)
            : null,
        'altura': altura != null ? int.tryParse(altura!) : null,
        'peso': peso != null ? int.tryParse(peso!) : null,
        'pe_dominante': peDominante,
        'posicao_principal': posicaoPrincipal ?? '',
        'posicoes_secundarias': posicoesSecundarias.isNotEmpty
            ? posicoesSecundarias.join(',')
            : null,
        'niveis': niveis.isNotEmpty ? niveis.join(',') : null,
        'overall': 50,
        'level': 1,
        'badges': badgesSelecionadas.isNotEmpty
            ? badgesSelecionadas.toList()
            : [],
        'categoria': null,
      });

      // 4. Insere em localizacao_usuario
      await supabase.from('localizacao_usuario').insert({
        'id_usuario': idUsuario,
        'nacionalidade': nacionalidade,
        'estado': estado,
        'cidade': cidade,
        'bairro': bairro,
        'cep': cep,
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
      Navigator.pushReplacementNamed(context, '/'); // rota para login
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro Auth: ${e.message}"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e"), backgroundColor: Colors.red),
      );
    }
  }
}
