class CadastroTorcedorModel {
  final String nome;
  final String apelido;
  final String email;
  final String senha;
  final String confirmarSenha;
  final String dataNascimento;
  final String cidade;
  final String bairro;
  final String cep;
  final String estado;
  final String nacionalidade;
  final String? timeCoracao;
  final Map<String, bool> notificacoes;

  CadastroTorcedorModel({
    required this.nome,
    required this.apelido,
    required this.email,
    required this.senha,
    required this.confirmarSenha,
    required this.dataNascimento,
    required this.cidade,
    required this.bairro,
    required this.cep,
    required this.estado,
    required this.nacionalidade,
    this.timeCoracao,
    required this.notificacoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'apelido': apelido,
      'email': email,
      'senha': senha,
      'confirmar_senha': confirmarSenha,
      'data_nascimento': dataNascimento,
      'cidade': cidade,
      'bairro': bairro,
      'cep': cep,
      'estado': estado,
      'nacionalidade': nacionalidade,
      'time_coracao': timeCoracao,
      'notificacoes': notificacoes,
    };
  }
}
