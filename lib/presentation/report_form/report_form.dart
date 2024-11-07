import 'package:budgey/domain/report_type.dart';
import 'package:budgey/presentation/report_form/controller.dart';
import 'package:flutter/material.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Map<String, dynamic>? selectedType;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add new report"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(
                context,
                true,
              ); // Pass true to indicate data was added
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom + 120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                    ),
                    DropdownButton<Map<String, dynamic>>(
                      hint: const Text("Select Spending Type"),
                      value: selectedType,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          selectedType = newValue;
                        });
                      },
                      items: ReportType.spendingTypes.map((e) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: e,
                          child: Row(
                            children: [
                              Icon(e['icon'], color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(e['text']),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: const InputDecoration(
                        hintText: "Rp...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await ReportFormController.insert(
                      amountController,
                      descriptionController,
                      selectedType?['text'],
                      context,
                    );
                    amountController.text = '';
                    descriptionController.text = '';
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
