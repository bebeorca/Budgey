import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyConverter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String formattedHarga = newValue.text;

    formattedHarga = formattedHarga.replaceAll(RegExp(r'[^0-9]'), '');

    if (formattedHarga.isNotEmpty) {
      final formatter = NumberFormat.currency(
        locale: 'id',
        symbol: '',
        decimalDigits: 0,
      );
      formattedHarga = formatter.format(int.parse(formattedHarga));
    }

    return TextEditingValue(
      text: formattedHarga,
      selection: TextSelection.collapsed(offset: formattedHarga.length),
    );
  }

  static String toIDR(dynamic n, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(n);
  }
}
