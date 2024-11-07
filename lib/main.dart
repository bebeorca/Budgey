import 'package:budgey/presentation/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budgey',
      theme: ThemeData(
        textTheme: GoogleFonts.rubikTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ReportsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
