import 'package:budgey/controller/currency_converter.dart';
import 'package:budgey/data/db.dart';
import 'package:budgey/domain/report_type.dart';
import 'package:budgey/presentation/components/Card/card_model.dart';
import 'package:budgey/presentation/report_form/controller.dart';
import 'package:flutter/material.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({
    super.key,
    required this.typeOfSpent,
    required this.id,
  });
  final String typeOfSpent;
  final int id;

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<Map<String, dynamic>> report = [];
  Map<String, dynamic> selectedType = {};

  void getReport() async {
    widget.id != 0 ? report = await Database.getReportByID(widget.id) : null;
    setState(() {
      if (report.isNotEmpty) {
        amountController.text = CurrencyConverter.toIDR(report[0]['amount'], 0);
        descriptionController.text = report[0]['description'];
      }
    });
  }

  @override
  void initState() {
    selectedType = widget.typeOfSpent != ''
        ? ReportType.spendingTypes
            .firstWhere((e) => e['text'] == widget.typeOfSpent)
        : ReportType.spendingTypes.first;
    getReport();
    super.initState();
  }

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
          title: report.isNotEmpty
              ? const Text("Edit report")
              : widget.typeOfSpent != ''
                  ? Text("Add new ${widget.typeOfSpent} report")
                  : const Text("Add new report"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(
                context,
                true,
              );
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
                    const SizedBox(height: 10),
                    report.isNotEmpty || widget.typeOfSpent == ''? DropdownButtonHideUnderline(
                            child: DropdownButton<Map<String, dynamic>>(
                              value: selectedType,
                              isExpanded: true,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedType = newValue!;
                                });
                              },
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              items: ReportType.spendingTypes.map((e) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: e,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: CardModel.getColor(
                                            e['text'],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Icon(
                                          CardModel.getIconForType(
                                            e['text'],
                                          ),
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(e['text']),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: CardModel.getColor(
                                    selectedType['text'],
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  CardModel.getIconForType(
                                    selectedType['text'],
                                  ),
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(selectedType['text']),
                            ],
                          ),
                    const SizedBox(height: 10),
                    TextFormField(
                      inputFormatters: [
                        CurrencyConverter(),
                      ],
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
                    final replacedAmount =
                        amountController.text.replaceAll(RegExp(r'[Rp.]'), '');
                    final parsedAmount = double.parse(replacedAmount);
                    if (report.isNotEmpty) {
                      await ReportFormController.update(
                        widget.id,
                        descriptionController.text,
                        parsedAmount,
                        selectedType['text'],
                        "Data updated!",
                        context,
                      );
                      Future.delayed(const Duration(seconds: 1))
                          .then((onValue) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, true);
                      });
                    } else {
                      await ReportFormController.insert(
                        descriptionController.text,
                        parsedAmount,
                        selectedType['text'],
                        "New data added!",
                        context,
                      );
                    }
                    amountController.text = '';
                    descriptionController.text = '';
                  },
                  child: Text(
                    report.isNotEmpty ? "Update" : "Save",
                    style: const TextStyle(fontSize: 17, color: Colors.white),
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
