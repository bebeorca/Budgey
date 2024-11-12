import 'package:budgey/controller/report_controller.dart';
import 'package:budgey/data/db.dart';
import 'package:budgey/presentation/components/Card/report_card.dart';
import 'package:budgey/presentation/report_form/report_form.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SpentsScreen extends StatefulWidget {
  const SpentsScreen({
    super.key,
    required this.type,
  });

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
          title: Text(widget.type),
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
                          confirmDismiss: (direction) async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Are you sure?"),
                                content: const Text(
                                    "Do you really want to delete this record?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color.fromARGB(
                                            255, 166, 174, 191),
                                      ),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Confirm deletion
                                      Navigator.pop(context, true);
                                      await Database.delete(
                                          reports[index]['id']);
                                      getReports(); // Refresh the list if necessary
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color.fromARGB(
                                            255, 250, 64, 50),
                                      ),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            // If deletion is confirmed, return true to allow the widget to be dismissed
                            return result == true;
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
                          child: ReportCard(
                            id: reports[index]['id'],
                            type: reports[index]["type"],
                            amount: reports[index]["amount"],
                            description: reports[index]["description"],
                            date: reports[index]["date"],
                            getReports: getReports,
                            isReport: false,
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
                builder: (context) => ReportForm(
                  id: 0,
                  typeOfSpent: widget.type,
                ),
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
