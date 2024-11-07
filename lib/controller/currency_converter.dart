import 'package:intl/intl.dart';

class CurrencyConverter {
  static String toIDR(dynamic n, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(n);
  }
}
