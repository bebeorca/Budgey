import 'package:budgey/controller/report_controller.dart';
import 'package:budgey/data/db.dart';
import 'package:budgey/presentation/components/Card/report_card.dart';
import 'package:budgey/presentation/components/Card/spent_card.dart';
import 'package:budgey/presentation/report_form/report_form.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SpentsScreen extends StatefulWidget {
  const SpentsScreen({super.key, required this.type});

  final String type;

  @override
  State<SpentsScreen> createState() => _SpentsScreenState();
}

class _SpentsScreenState extends State<SpentsScreen> {
  List<Map<String, dynamic>> reports = [];

  void getReports() async {
    final report = await Database.getSpents(widget.type);
    setState(() {
      reports = report;
    });
  }

  @override
  void initState() {
    super.initState();
    getReports();
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
          title: const Text('Reports'),
          actions: [
            // Display total amount spent on the app bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: ${ReportController.totalSpent(reports)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        body: reports.isNotEmpty
            ? Column(
                children: [
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
                              // totalSpent();
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
                          child: SpentCard(
                            type: reports[index]["type"],
                            amount: reports[index]["amount"],
                            description: reports[index]["description"],
                            date: reports[index]["date"],
                            getReports: null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  "Empty data",
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
      ),
    );
  }
}