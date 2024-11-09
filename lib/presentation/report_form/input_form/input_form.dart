import 'package:flutter/material.dart';

class InputFormCard extends StatelessWidget {
  const InputFormCard({
    super.key,
    required this.amountController,
    required this.itemController,
  });
  final TextEditingController amountController;
  final TextEditingController itemController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: itemController,
              decoration: const InputDecoration(
                hintText: "Item",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Rp ...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
