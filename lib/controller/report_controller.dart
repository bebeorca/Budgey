import 'package:budgey/controller/currency_converter.dart';

class ReportController {
  static String totalSpent(List<Map<String, dynamic>> reports) {
    int total = 0;
    for (var e in reports) {
      int parsedAmount = (e['amount'] as num).toInt();
      total += parsedAmount;
    }
    return CurrencyConverter.toIDR(total, 2);
  }

  static int eachItemSpent(List<Map<String, dynamic>> reports, String type) {
    int total = 0;
    var foodReports = reports.where((e) => e['type'] == type).toList();
    for (var e in foodReports) {
      int parsedAmount = (e['amount'] as num).toInt();
      total += parsedAmount;
    }
    return total;
  }
}
