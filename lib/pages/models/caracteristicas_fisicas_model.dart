class CaracteristicasFisicasModel {
  int? altura; // em cm (ex: 175)
  double? peso; // em kg (ex: 72.5)
  String? peDominante; // "Destro", "Canhoto", "Ambidestro"

  CaracteristicasFisicasModel({this.altura, this.peso, this.peDominante});

  Map<String, dynamic> toMap() => {
    'altura': altura,
    'peso': peso,
    'peDominante': peDominante,
  };

  factory CaracteristicasFisicasModel.fromMap(Map<String, dynamic> map) =>
      CaracteristicasFisicasModel(
        altura: map['altura'],
        peso: (map['peso'] as num?)?.toDouble(),
        peDominante: map['peDominante'],
      );
}
