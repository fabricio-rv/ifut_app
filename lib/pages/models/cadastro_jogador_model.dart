import 'dados_pessoais_model.dart';
import 'caracteristicas_fisicas_model.dart';
import 'localizacao_model.dart';
import 'jogo_model.dart';

class CadastroJogadorModel {
  DadosPessoaisModel dadosPessoais;
  CaracteristicasFisicasModel caracteristicasFisicas;
  LocalizacaoModel localizacao;
  JogoModel jogo;

  CadastroJogadorModel({
    required this.dadosPessoais,
    required this.caracteristicasFisicas,
    required this.localizacao,
    required this.jogo,
  });

  Map<String, dynamic> toMap() => {
    'dadosPessoais': dadosPessoais.toMap(),
    'caracteristicasFisicas': caracteristicasFisicas.toMap(),
    'localizacao': localizacao.toMap(),
    'jogo': jogo.toMap(),
  };

  factory CadastroJogadorModel.fromMap(Map<String, dynamic> map) =>
      CadastroJogadorModel(
        dadosPessoais: DadosPessoaisModel.fromMap(
          Map<String, dynamic>.from(map['dadosPessoais']),
        ),
        caracteristicasFisicas: CaracteristicasFisicasModel.fromMap(
          Map<String, dynamic>.from(map['caracteristicasFisicas']),
        ),
        localizacao: LocalizacaoModel.fromMap(
          Map<String, dynamic>.from(map['localizacao']),
        ),
        jogo: JogoModel.fromMap(Map<String, dynamic>.from(map['jogo'])),
      );
}
