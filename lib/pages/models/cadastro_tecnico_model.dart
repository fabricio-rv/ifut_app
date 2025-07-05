// models/cadastro_tecnico_model.dart
import 'experiencia_model.dart';
import 'disponibilidade_model.dart';

class CadastroTecnicoModel {
  final String nome;
  final String apelido;
  final String email;
  final String senha;
  final String confirmarSenha;
  final String? fotoPerfil;
  final String? nacionalidade;
  final String? estado;
  final String? cidade;
  final String? bairro;
  final String? cep;
  final String? experiencia;
  final String? disponibilidade;
  final List<String> niveisQueTreina;
  final List<String> estilosTaticos;

  CadastroTecnicoModel({
    required this.nome,
    required this.apelido,
    required this.email,
    required this.senha,
    required this.confirmarSenha,
    this.fotoPerfil,
    this.nacionalidade,
    this.estado,
    this.cidade,
    this.bairro,
    this.cep,
    this.experiencia,
    this.disponibilidade,
    required this.niveisQueTreina,
    required this.estilosTaticos,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'apelido': apelido,
      'email': email,
      'senha': senha,
      'confirmarSenha': confirmarSenha,
      'fotoPerfil': fotoPerfil,
      'nacionalidade': nacionalidade,
      'estado': estado,
      'cidade': cidade,
      'bairro': bairro,
      'cep': cep,
      'experiencia': experiencia,
      'disponibilidade': disponibilidade,
      'niveisQueTreina': niveisQueTreina,
      'estilosTaticos': estilosTaticos,
    };
  }
}
