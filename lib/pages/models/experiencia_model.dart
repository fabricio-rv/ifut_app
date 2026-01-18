// models/experiencia_model.dart
class ExperienciaModel {
  final String valor;

  ExperienciaModel({required this.valor});

  static List<ExperienciaModel> exemplos = [
    ExperienciaModel(valor: 'Nenhuma'),
    ExperienciaModel(valor: 'Só na Resenha'),
    ExperienciaModel(valor: '-1 anos'),
    ExperienciaModel(valor: '1-3 anos'),
    ExperienciaModel(valor: '3-5 anos'),
    ExperienciaModel(valor: '+5 anos'),
  ];
}
