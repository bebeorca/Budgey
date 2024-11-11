import 'package:budgey/data/db.dart';
import 'package:budgey/domain/report.dart';
import 'package:flutter/material.dart';

class ReportFormController {

  static void hitHandler(
    bool isInsert
  ){

  }

  static Future<void> insert(
    String descriptionController,
    double amount,
    String type,
    String message,
    BuildContext context,
  ) async {
    try {
      final now = DateTime.now();
      final report = Report(
        description: descriptionController,
        amount: amount,
        date: now.toString(),
        type: type,
      );
      await Database.insert(report);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
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

  static Future<void> update(
    int id,
    String description,
    double amount,
    String type,
    String message,
    BuildContext context,
  ) async {
    try {
      await Database.update(
        id,
        description,
        amount,
        type,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error!"),
        ),
      );
    }
  }
}
