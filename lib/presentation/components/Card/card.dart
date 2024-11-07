import 'package:budgey/controller/currency_converter.dart';
import 'package:budgey/presentation/components/Card/card_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatelessWidget {
  const ReportCard(
      {super.key,
      required this.description,
      required this.date,
      required this.amount,
      required this.type});
  final String description, date, type;
  final int amount;

  @override
  Widget build(BuildContext context) {
    
    final date = DateFormat("MMMM d, yyyy").format(
      DateTime.parse(this.date),
    );

    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(12),
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
                  description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 119, 119, 119),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  CurrencyConverter.toIDR(
                    amount,
                    2,
                  ),
                  style:
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
