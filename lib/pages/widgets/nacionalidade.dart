// lib/widgets/nacionalidade.dart

import 'package:flutter/material.dart';

// Lista de nacionalidades com nome, código e asset da bandeira
final List<Map<String, String>> nacionalidades = [
  {"sigla": "ALE", "nome": "Alemanha", "asset": "assets/bandeiras/ale.png"},
  {"sigla": "AGO", "nome": "Angola", "asset": "assets/bandeiras/ago.png"},
  {"sigla": "ARG", "nome": "Argentina", "asset": "assets/bandeiras/arg.png"},
  {"sigla": "BOL", "nome": "Bolívia", "asset": "assets/bandeiras/bol.png"},
  {"sigla": "BRA", "nome": "Brasil", "asset": "assets/bandeiras/bra.png"},
  {"sigla": "CPV", "nome": "Cabo Verde", "asset": "assets/bandeiras/cpv.png"},
  {"sigla": "CHL", "nome": "Chile", "asset": "assets/bandeiras/chl.png"},
  {"sigla": "CHN", "nome": "China", "asset": "assets/bandeiras/chn.png"},
  {"sigla": "COL", "nome": "Colômbia", "asset": "assets/bandeiras/col.png"},
  {"sigla": "ECU", "nome": "Equador", "asset": "assets/bandeiras/ecu.png"},
  {"sigla": "ESP", "nome": "Espanha", "asset": "assets/bandeiras/esp.png"},
  {
    "sigla": "EUA",
    "nome": "Estados Unidos",
    "asset": "assets/bandeiras/eua.png",
  },
  {"sigla": "FRA", "nome": "França", "asset": "assets/bandeiras/fra.png"},
  {"sigla": "HAI", "nome": "Haiti", "asset": "assets/bandeiras/hai.png"},
  {"sigla": "NLD", "nome": "Holanda", "asset": "assets/bandeiras/nld.png"},
  {"sigla": "ITA", "nome": "Itália", "asset": "assets/bandeiras/ita.png"},
  {"sigla": "JPN", "nome": "Japão", "asset": "assets/bandeiras/jpn.png"},
  {"sigla": "LBN", "nome": "Líbano", "asset": "assets/bandeiras/lbn.png"},
  {"sigla": "MOZ", "nome": "Moçambique", "asset": "assets/bandeiras/moz.png"},
  {"sigla": "PRY", "nome": "Paraguai", "asset": "assets/bandeiras/pry.png"},
  {"sigla": "PER", "nome": "Peru", "asset": "assets/bandeiras/per.png"},
  {"sigla": "POR", "nome": "Portugal", "asset": "assets/bandeiras/por.png"},
  {"sigla": "GBR", "nome": "Reino Unido", "asset": "assets/bandeiras/gbr.png"},
  {"sigla": "RUS", "nome": "Rússia", "asset": "assets/bandeiras/rus.png"},
  {"sigla": "SUI", "nome": "Suíça", "asset": "assets/bandeiras/sui.png"},
  {"sigla": "UKR", "nome": "Ucrânia", "asset": "assets/bandeiras/ukr.png"},
  {"sigla": "URU", "nome": "Uruguai", "asset": "assets/bandeiras/uru.png"},
  {"sigla": "VEN", "nome": "Venezuela", "asset": "assets/bandeiras/ven.png"},
];

// Widget reutilizável
class NacionalidadeDropdown extends StatelessWidget {
  final String? label;
  final String? value;
  final ValueChanged<String?> onChanged;
  final bool obrigatorio;

  const NacionalidadeDropdown({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
    this.obrigatorio = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        items: nacionalidades
            .map(
              (n) => DropdownMenuItem<String>(
                value: n['sigla'],
                child: Row(
                  children: [
                    Image.asset(
                      n['asset']!,
                      width: 28,
                      height: 19,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      n['nome']!,
                      style: const TextStyle(fontSize: 19, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      n['sigla']!,
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.public, color: Color(0xFF00FF00)),
          labelText: label ?? 'Nacionalidade',
          labelStyle: const TextStyle(
            color: Color(0xFF00FF00),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          filled: true,
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 1.8),
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2.6),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
            borderRadius: BorderRadius.circular(11),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
            borderRadius: BorderRadius.circular(14),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 25,
          ),
        ),
        dropdownColor: Colors.black,
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00FF00)),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
        hint: const Text(
          "Selecione",
          style: TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        validator: obrigatorio
            ? (v) => v == null || v.isEmpty ? "Campo obrigatório" : null
            : null,
      ),
    );
  }
}
