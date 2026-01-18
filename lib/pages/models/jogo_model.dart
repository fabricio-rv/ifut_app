class JogoModel {
  Set<String> niveis; // "Pereba", "Casual", ...
  String? posicaoPrincipal; // ex: "Ala E"
  Set<String> posicoesSecundarias; // até 3
  Set<String> badgesSelecionadas; // se houver
  String? escudoClube;
  List<String> estilosTaticos;
  List<String> niveisQueTreina;
  String? experiencia;
  String? disponibilidade;

  JogoModel({
    Set<String>? niveis,
    this.posicaoPrincipal,
    Set<String>? posicoesSecundarias,
    Set<String>? badgesSelecionadas,
    this.escudoClube,
    List<String>? estilosTaticos,
    List<String>? niveisQueTreina,
    this.experiencia,
    this.disponibilidade,
  }) : niveis = niveis ?? {},
       posicoesSecundarias = posicoesSecundarias ?? {},
       badgesSelecionadas = badgesSelecionadas ?? {},
       estilosTaticos = estilosTaticos ?? [],
       niveisQueTreina = niveisQueTreina ?? [];

  Map<String, dynamic> toMap() => {
    'niveis': niveis.toList(),
    'posicaoPrincipal': posicaoPrincipal,
    'posicoesSecundarias': posicoesSecundarias.toList(),
    'badgesSelecionadas': badgesSelecionadas.toList(),
    'escudoClube': escudoClube,
    'estilosTaticos': estilosTaticos,
    'niveisQueTreina': niveisQueTreina,
    'experiencia': experiencia,
    'disponibilidade': disponibilidade,
  };

  factory JogoModel.fromMap(Map<String, dynamic> map) => JogoModel(
    niveis: (map['niveis'] as List?)?.cast<String>().toSet() ?? {},
    posicaoPrincipal: map['posicaoPrincipal'],
    posicoesSecundarias:
        (map['posicoesSecundarias'] as List?)?.cast<String>().toSet() ?? {},
    badgesSelecionadas:
        (map['badgesSelecionadas'] as List?)?.cast<String>().toSet() ?? {},
    escudoClube: map['escudoClube'],
    estilosTaticos: (map['estilosTaticos'] as List?)?.cast<String>() ?? [],
    niveisQueTreina: (map['niveisQueTreina'] as List?)?.cast<String>() ?? [],
    experiencia: map['experiencia'],
    disponibilidade: map['disponibilidade'],
  );
}
