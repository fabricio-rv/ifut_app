// lib/widgets/estado_dropdown.dart

import 'package:flutter/material.dart';

// Lista dos estados brasileiros com nome, sigla e asset
final List<Map<String, String>> estadosBR = [
  {"sigla": "AC", "nome": "Acre", "asset": "assets/estados/ac.png"},
  {"sigla": "AL", "nome": "Alagoas", "asset": "assets/estados/al.png"},
  {"sigla": "AP", "nome": "Amapá", "asset": "assets/estados/ap.png"},
  {"sigla": "AM", "nome": "Amazonas", "asset": "assets/estados/am.png"},
  {"sigla": "BA", "nome": "Bahia", "asset": "assets/estados/ba.png"},
  {"sigla": "CE", "nome": "Ceará", "asset": "assets/estados/ce.png"},
  {"sigla": "DF", "nome": "Distrito Federal", "asset": "assets/estados/df.png"},
  {"sigla": "ES", "nome": "Espírito Santo", "asset": "assets/estados/es.png"},
  {"sigla": "GO", "nome": "Goiás", "asset": "assets/estados/go.png"},
  {"sigla": "MA", "nome": "Maranhão", "asset": "assets/estados/ma.png"},
  {"sigla": "MT", "nome": "Mato Grosso", "asset": "assets/estados/mt.png"},
  {
    "sigla": "MS",
    "nome": "Mato Grosso do Sul",
    "asset": "assets/estados/ms.png",
  },
  {"sigla": "MG", "nome": "Minas Gerais", "asset": "assets/estados/mg.png"},
  {"sigla": "PA", "nome": "Pará", "asset": "assets/estados/pa.png"},
  {"sigla": "PB", "nome": "Paraíba", "asset": "assets/estados/pb.png"},
  {"sigla": "PR", "nome": "Paraná", "asset": "assets/estados/pr.png"},
  {"sigla": "PE", "nome": "Pernambuco", "asset": "assets/estados/pe.png"},
  {"sigla": "PI", "nome": "Piauí", "asset": "assets/estados/pi.png"},
  {"sigla": "RJ", "nome": "Rio de Janeiro", "asset": "assets/estados/rj.png"},
  {
    "sigla": "RN",
    "nome": "Rio Grande do Norte",
    "asset": "assets/estados/rn.png",
  },
  {
    "sigla": "RS",
    "nome": "Rio Grande do Sul",
    "asset": "assets/estados/rs.png",
  },
  {"sigla": "RO", "nome": "Rondônia", "asset": "assets/estados/ro.png"},
  {"sigla": "RR", "nome": "Roraima", "asset": "assets/estados/rr.png"},
  {"sigla": "SC", "nome": "Santa Catarina", "asset": "assets/estados/sc.png"},
  {"sigla": "SP", "nome": "São Paulo", "asset": "assets/estados/sp.png"},
  {"sigla": "SE", "nome": "Sergipe", "asset": "assets/estados/se.png"},
  {"sigla": "TO", "nome": "Tocantins", "asset": "assets/estados/to.png"},
];

class EstadoDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? label;
  final bool obrigatorio;

  const EstadoDropdown({
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
        items: estadosBR
            .map(
              (e) => DropdownMenuItem<String>(
                value: e['sigla'],
                child: Row(
                  children: [
                    Image.asset(
                      e['asset']!,
                      width: 28,
                      height: 19,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      e['nome']!,
                      style: const TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      e['sigla']!,
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.map, color: Color(0xFF00FF00)),
          labelText: label ?? 'Estado',
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
