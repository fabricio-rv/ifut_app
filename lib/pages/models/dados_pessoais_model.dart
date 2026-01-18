class DadosPessoaisModel {
  String nome;
  String apelido;
  String email;
  String telefone;
  String senha;
  String confirmarSenha;
  DateTime? dataNascimento;
  String? fotoPerfil; // Pode ser path ou URL

  DadosPessoaisModel({
    required this.nome,
    required this.apelido,
    required this.email,
    required this.telefone,
    required this.senha,
    required this.confirmarSenha,
    this.dataNascimento,
    this.fotoPerfil,
  });

  Map<String, dynamic> toMap() => {
    'nome': nome,
    'apelido': apelido,
    'email': email,
    'telefone': telefone,
    'senha': senha,
    'confirmarSenha': confirmarSenha,
    'dataNascimento': dataNascimento?.toIso8601String(),
    'fotoPerfil': fotoPerfil,
  };

  factory DadosPessoaisModel.fromMap(Map<String, dynamic> map) =>
      DadosPessoaisModel(
        nome: map['nome'] ?? '',
        apelido: map['apelido'] ?? '',
        email: map['email'] ?? '',
        telefone: map['telefone'] ?? '',
        senha: map['senha'] ?? '',
        confirmarSenha: map['confirmarSenha'] ?? '',
        dataNascimento: map['dataNascimento'] != null
            ? DateTime.parse(map['dataNascimento'])
            : null,
        fotoPerfil: map['fotoPerfil'],
      );
}
