// widgets/dropdown_experiencia.dart
import 'package:flutter/material.dart';
import '../../models/experiencia_model.dart';

class DropdownExperiencia extends StatelessWidget {
  final List<String> experiencias; // obrigatório
  final String? value;
  final ValueChanged<String?>? onChanged;

  const DropdownExperiencia({
    Key? key,
    required this.experiencias, // obrigatório
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: DropdownButtonFormField<String>(
        value: value?.isEmpty == true ? null : value,
        isExpanded: true,
        items: experiencias
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
          prefixIcon: const Icon(Icons.history, color: Color(0xFF00FF00)),
          labelText: "Experiência",
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
