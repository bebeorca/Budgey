import 'package:flutter/material.dart';

class InsertReportForm extends StatelessWidget {
  const InsertReportForm(
      {super.key,
      required this.amountController,
      required this.descriptionController,
      required this.id,
      required this.onSave});

  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final int? id;
  final Future<void> Function()? onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 120,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: amountController,
            decoration: const InputDecoration(
              hintText: "Amount",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: "Description",
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (onSave != null) await onSave!();
              Navigator.of(context).pop();
            },
            child: Text(id == null ? "Create New" : "Update"),
          ),
        ],
      ),
    );
  }
}
