// models/disponibilidade_model.dart
class DisponibilidadeModel {
  final String valor;

  DisponibilidadeModel({required this.valor});

  static List<DisponibilidadeModel> exemplos = [
    DisponibilidadeModel(valor: 'Muito Baixa'),
    DisponibilidadeModel(valor: 'Baixa'),
    DisponibilidadeModel(valor: 'Média'),
    DisponibilidadeModel(valor: 'Alta'),
    DisponibilidadeModel(valor: 'Muito Alta'),
  ];
}
