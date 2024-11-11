import 'package:budgey/data/db.dart';
import 'package:budgey/domain/report.dart';
import 'package:flutter/material.dart';

class ReportFormController {
  static Future<void> insert(
    TextEditingController amountController,
    TextEditingController descriptionController,
    String type,
    BuildContext context,
  ) async {
    try {
      final now = DateTime.now();
      final replacedAmount = amountController.text.replaceAll(RegExp(r'[Rp.]'), '');
      final parsedAmount = double.parse(replacedAmount);
      final report = Report(
        description: descriptionController.text,
        amount: parsedAmount,
        date: now.toString(),
        type: type,
      );
      await Database.insert(report);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Added new report!"),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error"),
        ),
      );
    }
  }
}
