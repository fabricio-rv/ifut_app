import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarioController extends ChangeNotifier {
  final TextEditingController dataCtrl = TextEditingController();

  CalendarioController({String? dataInicial}) {
    if (dataInicial != null && dataInicial.isNotEmpty) {
      dataCtrl.text = dataInicial;
    }
    dataCtrl.addListener(() {
      notifyListeners();
    });
  }

  String get data => dataCtrl.text;

  set data(String valor) {
    dataCtrl.text = valor;
    notifyListeners();
  }

  void limpar() {
    data = '';
    notifyListeners();
  }

  /// Abre o date picker e atualiza a data selecionada
  Future<void> escolherData(BuildContext context) async {
    DateTime? dataInicial = _parseData(dataCtrl.text) ?? DateTime(1980);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataInicial,
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
      dataCtrl.text = formatted;
      notifyListeners();
    }
  }

  DateTime? _parseData(String text) {
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(text);
    } catch (_) {
      return null;
    }
  }

  DateTime? get dataDateTime {
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(dataCtrl.text);
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    dataCtrl.dispose();
    super.dispose();
  }
}
