import 'package:flutter/material.dart';

class CampoData extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final VoidCallback onCalendario;
  final Function(String)? onChanged;

  const CampoData({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    required this.onCalendario,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: GestureDetector(
        onTap: onCalendario,
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            keyboardType: TextInputType.datetime,
            style: const TextStyle(color: Colors.white, fontSize: 21),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFF00FF00)),
              labelText: label,
              labelStyle: const TextStyle(
                color: Color(0xFF00FF00),
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
              hintText: "Ex: 25/12/2000",
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 17),
              filled: true,
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 22,
                horizontal: 18,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF00FF00),
                  width: 1.8,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF00FF00),
                  width: 2.6,
                ),
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
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: Color(0xFF00FF00),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
