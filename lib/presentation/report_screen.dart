import 'package:budgey/controller/report_controller.dart';
import 'package:budgey/data/db.dart';
import 'package:budgey/presentation/components/Card/report_card.dart';
import 'package:budgey/presentation/report_form/report_form.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Map<String, dynamic>> reports = [];
  double amount = 0.0;

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

  @override
  void initState() {
    super.initState();
    getReports();
  }

  @override
  Widget build(BuildContext context) {
    // Extract unique types from the reports
    List<String> uniqueTypes = [];
    for (var report in reports) {
      if (!uniqueTypes.contains(report['type'])) {
        uniqueTypes.add(report['type']);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: ${ReportController.totalSpent(reports)}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : uniqueTypes.isEmpty
                ? const Center(
                    child: Text("No reports available"),
                  )
                : ListView.builder(
                    itemCount: uniqueTypes.length,
                    itemBuilder: (context, index) {
                      String type = uniqueTypes[index];
                      var filteredReport = reports.firstWhere(
                        (report) => report['type'] == type,
                      );
                      return ReportCard(
                        id: filteredReport['id'],
                        amount: ReportController.eachItemSpent(reports, type),
                        description: filteredReport['description'],
                        date: filteredReport['date'],
                        type: filteredReport['type'],
                        isReport: true,
                        getReports: getReports,
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dataUpdated = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReportForm(
                typeOfSpent: '',
                id: 0,
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
    );
  }
}
