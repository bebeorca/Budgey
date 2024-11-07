import 'package:budgey/controller/currency_converter.dart';
import 'package:budgey/data/db.dart';
import 'package:budgey/presentation/components/Card/card.dart';
import 'package:budgey/presentation/components/insert_form.dart';
import 'package:budgey/presentation/report_form/report_form.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Map<String, dynamic>> reports = [];
  bool isLoading = true;

  void getReports() async {
    final report = await Database.index();
    setState(() {
      reports = report;
      isLoading = false;
    });
  }

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void showForm(int? id) async {
    if (id != null) {
      final existingData = reports.firstWhere((element) => element['id'] == id);
      amountController.text = existingData['amount'];
      descriptionController.text = existingData['description'].toString();
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => InsertReportForm(
        amountController: amountController,
        descriptionController: descriptionController,
        id: id,
        onSave: () async {
          if (id == null) {
            // await insert();
          } else {
            // await updateItem(id);
          }
          amountController.clear();
          descriptionController.clear();
        },
      ),
    );
  }

  String totalSpent() {
    int total = 0;
    for (var e in reports) {
      int parsedAmount = (e['amount'] as num).toInt();
      total += parsedAmount;
    }
    return CurrencyConverter.toIDR(total, 2);
  }

  @override
  void initState() {
    super.initState();
    getReports();
    totalSpent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: reports.isNotEmpty
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Total spent: ${totalSpent()}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(reports[index].toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            await Database.delete(reports[index]["id"]);
                            setState(() {
                              getReports();
                              totalSpent();
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Card(
                            child: ReportCard(
                              type: reports[index]["type"],
                              amount: reports[index]["amount"],
                              description: reports[index]["description"],
                              date: reports[index]["date"],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Calculate total outside the ListView to avoid accumulating on rebuilds
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "Total: "),
                  // ),
                ],
              )
            : const Center(
                child: Text("Empty data"),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dataUpdated = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReportForm(),
            ),
          );

          if (dataUpdated == true) {
            // Refresh reports if data was updated
            getReports();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
