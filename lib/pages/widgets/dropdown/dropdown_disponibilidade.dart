// widgets/dropdown_disponibilidade.dart
import 'package:flutter/material.dart';
import '../../models/disponibilidade_model.dart';

class DropdownDisponibilidade extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<String> disponiveis;

  const DropdownDisponibilidade({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.disponiveis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: DropdownButtonFormField<String>(
        value: value?.isEmpty == true ? null : value,
        isExpanded: true,
        items: disponiveis
            .map(
              (v) => DropdownMenuItem(
                value: v,
                child: Text(
                  v,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        dropdownColor: Colors.black,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.hourglass_empty,
            color: Color(0xFF00FF00),
          ),
          labelText: "Disponibilidade",
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
      ),
    );
  }
}
