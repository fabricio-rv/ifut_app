// calendario.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarioCampo extends StatefulWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CalendarioCampo({
    Key? key,
    required this.label,
    required this.icon,
    this.initialValue,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  State<CalendarioCampo> createState() => _CalendarioCampoState();
}

class _CalendarioCampoState extends State<CalendarioCampo> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void didUpdateWidget(covariant CalendarioCampo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_controller.text) ?? DateTime(1980),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00FF00),
              onPrimary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final formatted = DateFormat('dd/MM/yyyy').format(picked);
      _controller.text = formatted;
      if (widget.onChanged != null) widget.onChanged!(formatted);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon, color: const Color(0xFF00FF00)),
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
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today, color: Color(0xFF00FF00)),
          onPressed: _selectDate,
        ),
      ),
      onTap: _selectDate,
    );
  }
}
