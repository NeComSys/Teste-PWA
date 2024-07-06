// ignore_for_file: avoid_print

import 'package:intl/intl.dart';

class Utils {
  static bool isDate(String input, String format) {
    try {
      final DateTime d = DateFormat(format).parseStrict(input);
      print(d);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static doubleConvert(value) {
    return (value.isEmpty
        ? 0
        : double.parse(value.replaceAll('.', '').replaceAll(',', '.')));
  }

  static Map<String, dynamic> converterObjectKeyToLowerCase(
      Map<String, dynamic> meuObjeto) {
    Map<String, dynamic> novoObjeto = {};
    meuObjeto.forEach((chave, valor) {
      novoObjeto[chave.toLowerCase()] = valor;
    });
    return novoObjeto;
  }
}
