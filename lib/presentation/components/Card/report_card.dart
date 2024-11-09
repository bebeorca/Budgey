import 'package:budgey/controller/currency_converter.dart';
import 'package:budgey/presentation/components/Card/card_model.dart';
import 'package:budgey/presentation/spents_screen.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.description,
    required this.date,
    required this.amount,
    required this.type,
    required this.getReports,
  });
  final String description, date, type;
  final int amount;
  final Function? getReports;

  @override
  Widget build(BuildContext context) {
    // final date = DateFormat("MMMM d, yyyy").format(
    //   DateTime.parse(this.date),
    // );

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
                  type,
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
              ],
            ),
            InkWell(
              onTap: () async {
                final dataUpdated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpentsScreen(
                      type: type,
                    ),
                  ),
                );
                if(dataUpdated){
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

    // return Card(
    //   color: Colors.white,
    //   child: Container(
    //     padding: const EdgeInsets.all(12),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Container(
    //           padding: const EdgeInsets.all(8),
    //           decoration: BoxDecoration(
    //             color: CardModel.getColor(type),
    //             borderRadius: BorderRadius.circular(100),
    //           ),
    //           child: Icon(
    //             CardModel.getIconForType(type),
    //             size: 35,
    //             color: Colors.white,
    //           ),
    //         ),
    //         Column(
    //           children: [
    //             Text(
    //               description,
    //               style: const TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //             Text(
    //               date,
    //               style: const TextStyle(
    //                 color: Color.fromARGB(255, 119, 119, 119),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Column(
    //           children: [
    //             Text(
    //               CurrencyConverter.toIDR(
    //                 amount,
    //                 2,
    //               ),
    //               style: const TextStyle(
    //                   fontSize: 14, fontWeight: FontWeight.w500),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
