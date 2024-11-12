import 'package:budgey/controller/currency_converter.dart';
import 'package:budgey/presentation/components/Card/card_model.dart';
import 'package:budgey/presentation/report_form/report_form.dart';
import 'package:budgey/presentation/spents_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.id,
    required this.description,
    required this.date,
    required this.amount,
    required this.type,
    required this.getReports,
    required this.isReport,
  });
  final String description, date, type;
  final int amount, id;
  final Function? getReports;
  final bool isReport;

  @override
  Widget build(BuildContext context) {
    
    final date = DateFormat("MMMM d, yyyy").format(
      DateTime.parse(this.date),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: CardModel.getColor(type),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                CardModel.getIconForType(type),
                size: 35,
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                Text(
                  isReport ? type : description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  CurrencyConverter.toIDR(
                    amount,
                    2,
                  ),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                isReport
                    ? const SizedBox.shrink()
                    : Text(
                        date,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 156, 156, 156)),
                      ),
              ],
            ),
            InkWell(
              onTap: () async {
                final dataUpdated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => isReport
                        ? SpentsScreen(
                            type: type,
                          )
                        : ReportForm(
                            typeOfSpent: type,
                            id: id,
                          ),
                  ),
                );
                if (dataUpdated) {
                  getReports!();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            )
          ],
        ),
      ),
    );
  }
}
