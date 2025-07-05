class LocalizacaoModel {
  String? nacionalidade; // ex: "BRA"
  String? estado; // ex: "SP"
  String? cidade;
  String? bairro;
  String? cep;

  LocalizacaoModel({
    this.nacionalidade,
    this.estado,
    this.cidade,
    this.bairro,
    this.cep,
  });

  Map<String, dynamic> toMap() => {
    'nacionalidade': nacionalidade,
    'estado': estado,
    'cidade': cidade,
    'bairro': bairro,
    'cep': cep,
  };

  factory LocalizacaoModel.fromMap(Map<String, dynamic> map) =>
      LocalizacaoModel(
        nacionalidade: map['nacionalidade'],
        estado: map['estado'],
        cidade: map['cidade'],
        bairro: map['bairro'],
        cep: map['cep'],
      );
}
