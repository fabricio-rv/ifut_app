// widgets/dropdown_clubes.dart
import 'package:flutter/material.dart';

class DropdownClubes extends StatelessWidget {
  static const List<String> clubesFixos = [
    "Nenhum",
    "Flamengo",
    "Corinthians",
    "Palmeiras",
    "São Paulo",
    "Grêmio",
    "Atlético-MG",
    "Vasco",
    "Cruzeiro",
    "Outro",
  ];

  final String? value;
  final ValueChanged<String?> onChanged;

  const DropdownClubes({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: clubesFixos.contains(value) ? value : null,
      isExpanded: true,
      items: clubesFixos
          .map((c) => DropdownMenuItem<String>(value: c, child: Text(c)))
          .toList(),
      onChanged: onChanged,
      dropdownColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.sports_soccer, color: Color(0xFF00FF00)),
        labelText: "Time do coração",
        labelStyle: const TextStyle(
          color: Color(0xFF00FF00),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        filled: true,
        fillColor: Colors.black,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 22,
          horizontal: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00FF00), width: 1.8),
          borderRadius: BorderRadius.circular(11),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2.6),
          borderRadius: BorderRadius.circular(14),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(11),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 21,
      ),
      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00FF00)),
    );
  }
}
