import 'package:flutter/material.dart';

class CardModel {

  static IconData getIconForType(type) {
    if (type == 'Food') {
      return Icons.fastfood;
    } else if (type == 'Transportation') {
      return Icons.local_gas_station;
    } else if (type == 'Housing') {
      return Icons.home;
    } else if (type == 'Shopping') {
      return Icons.shopping_cart;
    } else if (type == 'Healthcare') {
      return Icons.health_and_safety;
    } else if (type == 'Education') {
      return Icons.school;
    } else if (type == 'Miscellaneous') {
      return Icons.attach_money;
    } else {
      return Icons.help;
    }
  }

  static Color getColor(type) {
      if (type == 'Food') {
        return const Color.fromARGB(255, 177, 214, 144);
      } else if (type == 'Transportation') {
        return const Color.fromARGB(255, 55, 175, 225);
      } else if (type == 'Housing') {
        return const Color.fromARGB(255, 200, 161, 224);
      } else if (type == 'Shopping') {
        return const Color.fromARGB(255, 255, 162, 76);
      } else if (type == 'Healthcare') {
        return const Color.fromARGB(255, 255, 119, 183);
      } else if (type == 'Education') {
        return const Color.fromARGB(255, 252, 222, 112);
      } else if (type == 'Miscellaneous') {
        return const Color.fromARGB(255, 0, 31, 63);
      } else {
        return const Color.fromARGB(255, 0, 31, 63);
      }
    }
}
